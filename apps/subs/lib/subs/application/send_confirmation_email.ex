defmodule Subs.Application.SendConfirmationEmail do
  alias Subs.UserRepo
  alias Subs.Outbound.Email

  def send(user, confirmation_url) do
    Email.send_confirmation_email(user.email, confirmation_url)
    UserRepo.update(user, %{"confirmation_sent_at" => NaiveDateTime.utc_now()})
  end
end
