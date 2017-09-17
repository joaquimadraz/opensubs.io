defmodule Subs.Repo.Migrations.AddArchivedAndArchivedAtToSubscriptions do
  use Ecto.Migration

  def change do
    alter table(:subscriptions) do
      add :archived, :boolean, default: false, null: false
      add :archived_at, :naive_datetime
    end
  end
end
