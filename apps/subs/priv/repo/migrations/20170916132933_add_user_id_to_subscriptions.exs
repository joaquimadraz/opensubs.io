defmodule Subs.Repo.Migrations.AddUserIdToSubscriptions do
  use Ecto.Migration

  def change do
    alter table(:subscriptions) do
      add :user_id, references("users"), null: false
    end
  end
end
