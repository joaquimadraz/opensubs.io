defmodule Subs.Outbound.Email do
  @moduledoc false

  def send_confirmation_email(to_email, confirmation_email) do
    Notifier.send_confirmation_email(to_email, confirmation_email)
  end
end
