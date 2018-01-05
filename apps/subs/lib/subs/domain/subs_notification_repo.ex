defmodule Subs.SubsNotificationRepo do
  @moduledoc false
  alias Ecto.Multi
  import Ecto.Query
  alias Subs.{Repo, SubsNotification}

  def create_from_subscription(subscription) do
    case Repo.transaction(create_transaction(subscription)) do
      {:ok, %{insert_subs_notification: subs_notification}} ->
        {:ok, subs_notification}
    end
  end

  defp create_transaction(subscription) do
    subscription = Repo.preload(subscription, :user)

    Multi.new()
    |> Multi.run(:init, fn _ -> {:ok, SubsNotification.create_changeset(subscription)} end)
    |> Multi.run(
      :insert_notification,
      &insert_notification(&1.init, subscription.user, "title", "body")
    )
    |> Multi.run(
      :insert_subs_notification,
      &insert_subs_notification(&1.init, &1.insert_notification, [subscription])
    )
  end

  defp insert_notification(subs_notification_changeset, user, title, body) do
    deliver_at = Ecto.Changeset.get_change(subs_notification_changeset, :deliver_at)

    Notifier.create_notification(user.email, title, body, deliver_at)
  end

  defp insert_subs_notification(subs_notification_changeset, notification, subscriptions) do
    subs_notification_changeset
    |> Ecto.Changeset.put_assoc(:notification, notification)
    |> Ecto.Changeset.put_assoc(:subscriptions, subscriptions)
    |> Repo.insert()
  end
end
