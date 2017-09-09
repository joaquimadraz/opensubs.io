defmodule Subs.UseCases.Users.AuthenticateUser do
  @moduledoc false

  use Subs.UseCase
  alias Subs.User

  def perform(email, password) do
    with {:ok, user} <- User.authenticate(email, password) do
      ok!(%{user: user})
    else
      :error -> failure!(:invalid_credentials)
    end
  end
end
