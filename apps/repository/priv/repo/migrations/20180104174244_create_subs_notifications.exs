defmodule Repository.Repo.Migrations.CreateSubsNotifications do
  use Ecto.Migration

  def change do
    create table(:subs_notifications) do
      add(:user_id, references("users"), null: false)
      add(:notification_id, references("notifications"), null: false)
      add(:status, :integer, default: 0, null: false)
      add(:type, :integer, default: 0, null: false)
      add(:deliver_at, :naive_datetime, null: false)

      timestamps()
    end
  end
end
