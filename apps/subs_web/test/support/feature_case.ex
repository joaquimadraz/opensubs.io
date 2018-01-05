defmodule SubsWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias Repository.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import SubsWeb.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repository.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Repository.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Repository.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
