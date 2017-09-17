defmodule Subs.SubscriptionRepo do
  @moduledoc false
  import Ecto.Query
  alias Subs.{Repo, Subscription}

  def create(params) do
    %Subscription{}
    |> Subscription.create_changeset(params)
    |> Repo.insert()
  end

  def update(subscription, params) do
    subscription
    |> Subscription.update_changeset(params)
    |> Repo.update()
  end

  def create_with_user(user, params) do
    Subscription.build_with_user(user, params)
    |> Repo.insert()
  end

  def get_user_subscriptions(user) do
    query = from s in Subscription,
      where: s.user_id == ^user.id and s.archived == false

    Repo.all(query)
  end

  def get_user_subscription(user, subscription_id) do
    Repo.get_by(Subscription, user_id: user.id, id: subscription_id)
  end
end
