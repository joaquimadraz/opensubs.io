defmodule Notifier.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add(:to, :string, null: false)
      add(:title, :string, null: false)
      add(:body, :text, null: false)
      add(:notify_at, :naive_datetime, null: false)
      add(:delivered, :boolean, default: false)

      timestamps()
    end

    create(index("notifications", [:notify_at]))
  end
end
