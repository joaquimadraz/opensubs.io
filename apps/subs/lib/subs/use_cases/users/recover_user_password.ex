defmodule Subs.UseCases.Users.RecoverUserPassword do
  @moduledoc false

  use Subs.UseCase
  alias Subs.{User, UserRepo}

  def perform(email) do
    with {:ok, user} <- find_user_by_email(email),
         {:ok, user} <- reset_password_fields(user) do
      ok!(%{user: user})
    else
      {:error, :user_not_found} -> failure!(:user_not_found)
    end
  end

  defp reset_password_fields(user) do
    {:ok, _} = UserRepo.reset_user_recover_password_fields(user)
  end

  def find_user_by_email(email) do
    case UserRepo.get_by_email(email) do
      nil -> {:error, :user_not_found}
      user -> {:ok, user}
    end
  end
end
