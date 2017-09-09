defmodule Subs.UseCases.Users.UpdateUser do
  @moduledoc false

  use Subs.UseCase
  alias Subs.UserRepo
  alias Subs.UseCases.Users.FindUser

  def perform(user_id, user_params) do
    with {:ok, %{user: user}} <- FindUser.perform(user_id) do
      update_user(user, user_params)
    else
      {:error, {:user_not_found, _}} ->
        failure!(:user_not_found)
    end
  end

  defp update_user(user, user_params) do
    with {:ok, user} <- UserRepo.update(user, user_params) do
      ok!(%{user: user})
    else
      {:error, changeset} ->
        failure!(:invalid_user_params, %{user: user,
                                         changeset: changeset})
    end
  end
end
