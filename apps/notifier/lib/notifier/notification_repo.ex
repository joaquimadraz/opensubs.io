defmodule Notifier.NotificationRepo do
  import Ecto.Query
  alias Notifier.{Repo, Notification}

  def create(params) do
    %Notification{}
    |> Notification.create_changeset(params)
    |> Repo.insert()
  end

  def deliver(notification, dt \\ Notifier.DT) do
    notification
    |> Notification.deliver_changeset(dt)
    |> Repo.update()
  end

  def deliver_failed(notification, reason, dt \\ Notifier.DT) do
    notification
    |> Notification.deliver_failed_changeset(reason, dt)
    |> Repo.update()
  end

  def get_by_id(id), do: Repo.get(Notification, id)

  def get_pending() do
    query = from(n in Notification, where: n.status == ^:pending)

    Repo.all(query)
  end
end
