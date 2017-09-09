defmodule Subs.Test.UseCases.Users.FindUserTest do
  use Subs.DataCase
  import Subs.Test.Support.Factory

  alias Subs.UseCases.Users.FindUser

  describe "given an user and his id" do
    setup [:create_user]
    setup context do
      {:ok, found} = FindUser.perform(context.created_user_id)

      found
    end

    test "should find user", %{user: user} do
      assert user != nil
    end
  end

  describe "given an user and unexisting id" do
    setup [:create_user]
    test "should not find user" do
      {:error, {error, _}} = FindUser.perform(-1)

      assert error == :user_not_found
    end
  end

  defp create_user(_) do
    [created_user_id: insert(:user).id]
  end
end
