defmodule SubsWeb.Helpers.UserHelper do
  alias SubsWeb.Router.Helpers

  def generate_confirmation_url(user) do
    Helpers.api_user_confirm_url(
      SubsWeb.Endpoint,
      :confirm,
      %{t: user.confirmation_token}
    )
  end
end
