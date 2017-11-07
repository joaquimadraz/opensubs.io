defmodule SubsWeb.Helpers.UserHelper do
  alias SubsWeb.Router.Helpers
  alias SubsWeb.Guardian

  def generate_confirmation_url(user) do
    Helpers.api_user_confirm_url(
      SubsWeb.Endpoint,
      :confirm,
      %{t: user.confirmation_token}
    )
  end

  def generate_recover_password_url(user) do
    Helpers.reset_password_url(
      SubsWeb.Endpoint,
      :reset_password,
      %{t: user.password_recovery_token}
    )
  end

  def current_user(conn), do: Guardian.Plug.current_resource(conn)

  def generate_auth_token(user) do
    {:ok, auth_token, _} = Guardian.encode_and_sign(user)
    auth_token
  end
end
