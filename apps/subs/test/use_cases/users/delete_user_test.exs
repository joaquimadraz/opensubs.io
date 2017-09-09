defmodule Subs.Test.UseCases.Users.DeleteUserTest do
  use Subs.DataCase
  import Subs.Test.Support.Factory

  alias Subs.UseCases.Users.DeleteUser

  describe "given an existing user" do
    setup [:create_user]

    test "deletes user", context do
      assert :ok = DeleteUser.perform(context.created_user_id)
    end

    test "returns error for invalid user" do
      {:error, {error, _}} = DeleteUser.perform(-1)

      assert error == :user_not_found
    end
  end

  defp create_user(_) do
    [created_user_id: insert(:user).id]
  end
end
