defmodule SubsWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias Subs.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import SubsWeb.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Subs.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Subs.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Subs.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
