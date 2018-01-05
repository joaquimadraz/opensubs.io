defmodule Repository.Repo.Migrations.CreateSubsNotificationsSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subs_notifications_subscriptions) do
      add(:subs_notification_id, references("subs_notifications"), null: false)
      add(:subscription_id, references("subscriptions"), null: false)
    end
  end
end
