defmodule Subs.Outbound.Email do
  @moduledoc false

  def send_confirmation_email(to_email, confirmation_url) do
    Notifier.send_confirmation_email(to_email, confirmation_url)
  end

  def send_recover_password_email(to_email, recover_url) do
    Notifier.send_recover_password_email(to_email, recover_url)
  end
end
