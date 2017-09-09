defmodule Subs.UseCases.Users.AuthenticateUser do
  @moduledoc false

  use Subs.UseCase
  alias Subs.{User, Guardian}

  def perform(email, password) do
    with {:ok, user} <- User.authenticate(email, password),
         {:ok, token, _} = Guardian.encode_and_sign(user) do
      ok!(%{user: user, auth_token: token})
    else
      :error -> failure!(:invalid_credentials)
    end
  end
end
