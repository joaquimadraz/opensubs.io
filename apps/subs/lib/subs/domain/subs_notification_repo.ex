defmodule Subs.SubsNotificationRepo do
  @moduledoc false
  alias Ecto.Multi
  import Ecto.Query
  alias Subs.SubsNotification
  alias Repository.Repo

  @dt Application.get_env(:subs, :dt)

  def create(user, subscriptions, type, template, now \\ @dt.now) do
    transaction = create_transaction(user, subscriptions, type, template, now)

    case Repo.transaction(transaction) do
      {:ok, %{insert_subs_notification: subs_notification}} ->
        {:ok, subs_notification}
    end
  end

  defp create_transaction(user, subscriptions, type, template, now) do
    Multi.new()
    |> Multi.run(:init, fn _ ->
      {:ok, SubsNotification.create_changeset(user, %{type: type, deliver_at: now})}
    end)
    |> Multi.run(
      :insert_notification,
      &insert_notification(&1.init, user, template, now)
    )
    |> Multi.run(
      :insert_subs_notification,
      &insert_subs_notification(&1.init, &1.insert_notification, subscriptions)
    )
  end

  defp insert_notification(_, user, template, now) do
    Notifier.create_notification(user.email, template.title, template.body, now)
  end

  defp insert_subs_notification(subs_notification_changeset, notification, subscriptions) do
    subs_notification_changeset
    |> Ecto.Changeset.put_assoc(:notification, notification)
    |> Ecto.Changeset.put_assoc(:subscriptions, subscriptions)
    |> Repo.insert()
  end
end
