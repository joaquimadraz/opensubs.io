defmodule Notifier do
  @moduledoc false
  alias Notifier.{Email, Mailer, NotificationRepo}

  def send_confirmation_email(to_email, confirmation_url) do
    to_email
    |> Email.confirmation_email(%{confirmation_url: confirmation_url})
    |> Mailer.deliver_now()
  end

  def send_recover_password_email(to_email, recover_url) do
    to_email
    |> Email.recover_password_email(%{recover_url: recover_url})
    |> Mailer.deliver_now()
  end

  def create_notification(to, title, body, notify_at) do
    {:ok, _notification} =
      NotificationRepo.create(%{
        to: to,
        title: title,
        body: body,
        notify_at: notify_at
      })
  end

  @doc """
  Deliver pending notifications
  """
  def deliver_notifications(dt \\ Notifier.DT) do
    pending = NotificationRepo.get_pending()
    delivered = Enum.map(pending, &deliver_notification(&1, dt))

    {:ok, delivered}
  end

  @doc """
  Deliver single notification
  """
  defp deliver_notification(notification, dt \\ Notifier.DT) do
    {:ok, notification} = NotificationRepo.deliver(notification, dt)
    notification
  end
end
