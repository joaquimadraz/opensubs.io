defmodule Subs.Application.SendRecoverPasswordEmail do
  alias Subs.Outbound.Email

  def send(user, recover_url) do
    Email.send_recover_password_email(user.email, recover_url)
    {:ok, user}
  end
end
