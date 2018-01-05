defmodule Repository.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :name, :string, null: false
      add :description, :string
      add :amount, :integer, null: false
      add :amount_currency, :string, null: false
      add :amount_currency_symbol, :string, null: false
      add :cycle, :string, null: false
      add :color, :string
      add :first_bill_date, :naive_datetime, null: false
      add :next_bill_date, :naive_datetime, null: false

      timestamps()
    end
  end
end
