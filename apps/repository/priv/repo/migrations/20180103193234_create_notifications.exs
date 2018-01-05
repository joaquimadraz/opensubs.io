defmodule Repository.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add(:to, :string, null: false)
      add(:title, :string, null: false)
      add(:body, :text, null: false)
      add(:notify_at, :naive_datetime, null: false)
      add(:status, :integer, default: 0, null: false)
      add(:failure_reason, :string)
      add(:try_deliver_at, :naive_datetime)

      timestamps()
    end

    create(index("notifications", [:notify_at]))
  end
end
