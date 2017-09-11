defmodule Subs.Test.UseCases.Users.ConfirmUserTest do
  use Subs.DataCase
  import Subs.Test.Support.Factory

  alias Subs.UseCases.Users.ConfirmUser

  test "returns error for unknown token" do
    assert {:error, {:invalid_token, _}} = ConfirmUser.perform("invalid")
  end

  describe "given a confirmed user" do
    setup do
      user = insert(:user, confirmed_at: NaiveDateTime.utc_now(),
                           confirmation_sent_at: NaiveDateTime.utc_now())

      [user: user]
    end

    test "returns error for user being confirmed", %{user: user} do
      assert {:error, {:user_confirmed, _}} = ConfirmUser.perform(user.confirmation_token)
    end
  end

  describe "given an unconfirmed user" do
    setup do
      [user: insert(:user, confirmation_sent_at: NaiveDateTime.utc_now())]
    end

    test "confirms user", %{user: user} do
      assert {:ok, %{user: user}} = ConfirmUser.perform(user.confirmation_token)

      assert user.confirmed_at != nil
      assert user.confirmed_at > user.confirmation_sent_at
    end
  end
end
