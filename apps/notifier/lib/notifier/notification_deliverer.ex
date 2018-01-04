defmodule Notifier.NotificationDeliverer do
  alias Notifier.{DT, NotificationRepo}

  def deliver(notification, dt \\ DT, mailer \\ Notifier.Mailer) do
    email = Notifier.Email.notification_email(notification)

    case mailer.safe_deliver(email) do
      {:ok, email} ->
        NotificationRepo.deliver(notification, dt)
      {:error, :smtp_error, error} ->
        message = "SMTP_ERROR: #{error}"
        {:ok, notification} = NotificationRepo.deliver_failed(notification, message, dt)
        {:error, notification}
      {:error, :unable_to_deliver, error} ->
        message = "UNKNOWN_ERROR: #{error}"
        {:ok, notification} = NotificationRepo.deliver_failed(notification, message, dt)
        {:error, notification}
    end
  end
end
