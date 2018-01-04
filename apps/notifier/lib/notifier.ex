defmodule Notifier do
  @moduledoc false
  alias Notifier.{
    DT,
    Email,
    Mailer,
    NotificationRepo,
    NotificationDeliverer
  }

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
  def deliver_notifications(dt \\ DT, deliverer \\ NotificationDeliverer) do
    pending = NotificationRepo.get_pending()

    Enum.map(pending, fn (notification) ->
      case deliverer.deliver(notification, dt) do
        {:ok, notification} -> notification
      end
    end)
  end
end
