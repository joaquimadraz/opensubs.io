# Subs (WIP) [![Build Status](https://travis-ci.org/joaquimadraz/subs.svg?branch=master)](https://travis-ci.org/joaquimadraz/subs)
## Manage on going subscriptions :money_with_wings:

### Stack
- Elixir backend
- React frontend
- PostgreSQL database

### How to run Subs
1. `mix deps.get`, to install dependencies
2. `mix ecto.setup`, to create and migrate the database
3. `cd apps/subs_web/frontend && yarn install`, to install frontend dependencies
3. `mix phx.server`, to run the server, will also build the frontend

- `cd apps/subs_web/frontend && node_modules/.bin/webpack --config webpack.config.js`, to build the frontend manually

#### Running tests
- `mix test`, to un all tests
- `mix test --only acceptance`, to run only acceptance tests

### MVP
#### Backend API
- [x] User signup/authentication
- [x] User password recovery
- [x] Services list
- [x] Subscriptions create
- [x] Subscriptions update
- [x] Subscriptions archive
- [x] Subscriptions list

#### Frontend
- [x] User signup/authentication
- [ ] User password recovery
- [x] Create custom subscription
  - [ ] Create from service service
- [x] List all subscriptions
- [ ] Subscriptions dashboard
  - [ ] Due this month
  - [ ] Due next month
  - [ ] Monthly payment
  - [ ] Yearly payment

### Nice to have
- [ ] Categorization (personal, business, services)
- [ ] Email notifications
- [ ] Web notifications

### Future
- [ ] Facebook bot

## License
MIT © [Joaquim Adraz](http://joaquimadraz.com)
