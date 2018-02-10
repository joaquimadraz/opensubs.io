#!/bin/bash

# If any of this commands fail, stop script.
set -e

# Set AWS access keys.
# This is required so that both aws-cli and ecs-cli can access you account 
# programmatically. You should have both AWS_ACCESS_KEY_ID and 
# AWS_SECRET_ACCESS_KEY from when we created the admin used. AWS_DEFAULT_REGION 
# is the code for the aws region you chose, eg: eu-west-2.
AWS_ACCESS_KEY_ID= # ------------------------------------------------- POPULATE
AWS_SECRET_ACCESS_KEY= # --------------------------------------------- POPULATE
AWS_DEFAULT_REGION= # ------------------------------------------------ POPULATE

# Set AWS ECS vars.
# Here you only need to set AWS_ECS_URL. I have created the others so that is 
# easy to change for your project.
AWS_ECS_URL= # ------------------------------------------------------- POPULATE
AWS_ECS_DOCKER_IMAGE=subs:latest
AWS_ECS_PROJECT_NAME=opensubs
AWS_ECS_CONTAINER_NAME=subs
AWS_ECS_CLUSTER_NAME=opensubs-production

# Set Build args.
# These are the build arguments we showed before. 
# Note that the DATABASE_URL needs to be set.
DATABASE_URL= # ------------------------------------------------------ POPULATE
PHOENIX_SECRET_KEY_BASE=super_secret_phoenix_key_base
SESSION_COOKIE_NAME=session_cookie_name
SESSION_COOKIE_SIGNING_SALT=super_secret_cookie_signing_salt
SESSION_COOKIE_ENCRYPTION_SALT=super_secret_cookie_encryption_salt

# Set runtime ENV.
# These are the run time environment variables. 
# Note that HOST needs to be set.
HOST= # -------------------------------------------------------------- POPULATE
PORT=80

# Build container.
# As we did before, now we are going to build the Docker image that will be 
# pushed to the repository.
docker build -t $AWS_ECS_CONTAINER_NAME \
  --build-arg PHOENIX_SECRET_KEY_BASE=$PHOENIX_SECRET_KEY_BASE \
  --build-arg SESSION_COOKIE_NAME=$SESSION_COOKIE_NAME \
  --build-arg SESSION_COOKIE_SIGNING_SALT=$SESSION_COOKIE_SIGNING_SALT \
  --build-arg SESSION_COOKIE_ENCRYPTION_SALT=$SESSION_COOKIE_ENCRYPTION_SALT \
  --build-arg DATABASE_URL=$DATABASE_URL \
  .

# # Tag docker image as latest on the ECS Repository.
docker tag $AWS_ECS_DOCKER_IMAGE "$AWS_ECS_URL"/"$AWS_ECS_DOCKER_IMAGE"

# Login to ECS Repository.
eval $(aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION)

# Upload the Docker image to the ECS Repository.
docker push "$AWS_ECS_URL"/"$AWS_ECS_DOCKER_IMAGE"

# Configure ECS cluster and AWS_DEFAULT_REGION so we don't have to send it 
# on every command
ecs-cli configure --cluster=$AWS_ECS_CLUSTER_NAME --region=$AWS_DEFAULT_REGION

# Build docker-compose.yml with our configuration.
# Here we are going to replace the docker-compose.yml placeholders with 
# our app's configurations
sed -i '.original' \
  -e 's/$AWS_ECS_URL/'$AWS_ECS_URL'/g' \
  -e 's/$AWS_ECS_DOCKER_IMAGE/'$AWS_ECS_DOCKER_IMAGE'/g' \
  -e 's/$AWS_ECS_CONTAINER_NAME/'$AWS_ECS_CONTAINER_NAME'/g' \
  -e 's/$HOST/'$HOST'/g' \
  -e 's/$PORT/'$PORT'/g' \
  config/deploy/docker-compose.yml

# Deregister old task definition. 
# Every deploy we want a new task definition to be created with the latest 
# configurations. Task definitions are a set of configurations that state 
# how the Docker container should run and what resources to use: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html
REVISION=$(aws ecs list-task-definitions --region $AWS_DEFAULT_REGION | jq '.taskDefinitionArns[]' | tr -d '"' | tail -1 | rev | cut -d':' -f 1 | rev)
if [ ! -z "$REVISION" ]; then
  aws ecs deregister-task-definition \
    --region $AWS_DEFAULT_REGION \
    --task-definition $AWS_ECS_PROJECT_NAME:$REVISION \
    >> /tmp/task_deregister_output.txt
fi

# Stop current task that is running ou application.
# This is what will stop the application. 
{
  ecs-cli compose \
    --file config/deploy/docker-compose.yml \
    --project-name "$AWS_ECS_PROJECT_NAME" \
    service stop
} || {
  echo "Couldn't stop service"
}

# Start new task which will create fresh new task definition as well.
# This is what will bring the application up with the new code and configurations.
ecs-cli compose \
  --file config/deploy/docker-compose.yml \
  --project-name "$AWS_ECS_PROJECT_NAME" \
  service up