defmodule Subs.UseCases.Users.ConfirmUser do
  @moduledoc false

  use Subs.UseCase
  alias Subs.{User, UserRepo}

  def perform(token) do
    with {:ok, user} <- find_user_by_confirmation_token(token),
         {:ok, user} <- confirm_user(user) do
      ok!(%{user: user})
    else
      {:error, error} -> failure!(error)
    end
  end

  defp confirm_user(user) do
    if User.confirmed?(user) do
      {:error, :user_confirmed}
    else
      case UserRepo.update(user, %{confirmed_at: NaiveDateTime.utc_now()}) do
        {:ok, user} -> {:ok, user}
        _ -> {:error, :unable_to_confirm_user}
      end
    end
  end

  def find_user_by_confirmation_token(token) do
    case UserRepo.get_by_confirmation_token(token) do
      nil -> {:error, :invalid_token}
      user -> {:ok, user}
    end
  end
end
