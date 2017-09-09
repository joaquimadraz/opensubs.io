defmodule Subs.UseCases.Users.FindUser do
  @moduledoc false

  use Subs.UseCase
  alias Subs.UserRepo

  def perform(user_id) do
    case UserRepo.get_by_id(user_id) do
      nil ->
        failure!(:user_not_found)
      user ->
        ok!(%{user: user})
    end
  end
end
