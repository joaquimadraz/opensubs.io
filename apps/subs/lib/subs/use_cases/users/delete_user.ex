defmodule Subs.UseCases.Users.DeleteUser do
  @moduledoc false

  use Subs.UseCase
  alias Subs.UserRepo

  def perform(user_id) do
    case UserRepo.get_by_id(user_id) do
      nil ->
        failure!(:user_not_found)
      user ->
        case UserRepo.delete(user) do
          {:ok, _} -> :ok
          {:error, _} -> failure!(:user_not_deleted)
        end
    end
  end
end
