defmodule Notifier do
  @moduledoc false
  alias Notifier.{Email, Mailer}

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
end
