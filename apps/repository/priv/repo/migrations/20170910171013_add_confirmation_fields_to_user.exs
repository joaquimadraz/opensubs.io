defmodule Repository.Repo.Migrations.AddConfirmationFieldsToUser do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :confirmation_token, :string, null: false
      add :confirmation_sent_at, :naive_datetime
      add :confirmed_at, :naive_datetime
    end

    create index("users", [:confirmed_at])
  end
end
