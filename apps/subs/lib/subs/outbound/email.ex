defmodule Subs.Outboud.Email do
  @moduledoc false

  @notifier Application.get_env(:subs, :notifier)

  def send_confirmation_email(to_email, confirmation_email, notifier \\ Notifier) do
    notifier.send_confirmation_email(to)
  end
end
