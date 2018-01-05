defmodule Repository.Repo.Migrations.AddServiceCodeToSubscriptions do
  use Ecto.Migration

  def change do
    alter table(:subscriptions) do
      add :service_code, :string
    end
  end
end
