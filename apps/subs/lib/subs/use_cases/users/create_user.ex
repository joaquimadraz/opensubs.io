defmodule Subs.UseCases.Users.CreateUser do
  @moduledoc false

  use Subs.UseCase
  alias Subs.UserRepo

  def perform(user_params) do
    case UserRepo.create(user_params) do
      {:ok, user} ->
        ok!(%{user: user})
      {:error, changeset} ->
        failure!(:invalid_params, %{changeset: changeset})
    end
  end
end
