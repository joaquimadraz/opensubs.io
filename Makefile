dev:
	iex -S mix phx.server

setup:
	brew install chromedriver
	mix deps.get
	mix ecto.setup
	MIX_ENV=test mix ecto.setup
	cd apps/subs_web/frontend && yarn install

test:
	HEADLESS_ACCEPTANCE=true mix test
