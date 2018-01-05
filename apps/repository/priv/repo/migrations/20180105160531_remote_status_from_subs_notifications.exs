defmodule Repository.Repo.Migrations.RemoteStatusFromSubsNotifications do
  use Ecto.Migration

  def change do
    alter table("subs_notifications") do
      remove :status
    end
  end
end
