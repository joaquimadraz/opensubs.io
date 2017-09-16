defmodule SubsWeb.Test.Support.ApiHelpers do
  @moduledoc false
  use Phoenix.ConnTest
  alias SubsWeb.Helpers.UserHelper

  def put_authorization_header(conn, user) do
    auth_token = UserHelper.generate_auth_token(user)
    put_req_header(conn, "authorization", "Bearer #{auth_token}")
  end
end
