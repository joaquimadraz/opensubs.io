defmodule Notifier.NotificationRepo do
  alias Notifier.{Repo, Notification}

  def create(params) do
    %Notification{}
    |> Notification.create_changeset(params)
    |> Repo.insert()
  end

  def get_by_id(id), do: Repo.get(Notification, id)
end
