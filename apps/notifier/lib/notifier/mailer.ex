defmodule Notifier.Mailer do
  use Bamboo.Mailer, otp_app: :notifier

  def safe_deliver(email) do
    try do
      email = Notifier.Mailer.deliver_now(email)
      {:ok, email}
    rescue
      e in Bamboo.SMTPAdapter.SMTPError ->
        {:error, :smtp_error, e.message}
      e ->
        {:error, :unable_to_deliver, e.message}
    end
  end
end
