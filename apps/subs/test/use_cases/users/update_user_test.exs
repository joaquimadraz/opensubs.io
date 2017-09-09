defmodule Subs.Test.UseCases.Users.UpdateUserTest do
  use Subs.DataCase
  import Subs.Test.Support.Factory

  alias Subs.UseCases.Users.UpdateUser

  @bcrypt Application.get_env(:subs, :bcrypt)

  describe "given user and an unknown user to update" do
    test "should return user_not_found error" do
      {:error, {error, _}} = UpdateUser.perform(-1, %{})

      assert error == :user_not_found
    end
  end

  describe "given user and only password to update" do
    setup [:create_user]
    setup context do
      {:error, {:invalid_user_params, not_updated}} =
        UpdateUser.perform(context.user.id, %{password: "abcdef"})

      not_updated
    end

    test "should return error for missing password_confirmation", %{changeset: changeset} do
      {message, _} = changeset.errors[:password_confirmation]
      assert message == "can't be blank"
    end
  end

  describe "given user and not matching password/password_confirmation" do
    setup [:create_user]
    setup context do
      {:error, {:invalid_user_params, %{user: user, changeset: changeset}}} =
        UpdateUser.perform(context.user.id, %{password: "abcdef",
                                              password_confirmation: "bcdefg"})

      [user: user, user_id: context.user.id, changeset: changeset]
    end

    test "should return user to update", %{user: user, user_id: user_id} do
      assert user.id == user_id
    end

    test "should return error for not matching password_confirmation/password", %{changeset: changeset} do
      {message, _} = changeset.errors[:password_confirmation]
      assert message == "does not match confirmation"
    end
  end

  describe "given user and matching passwords/password_confirmation" do
    setup [:create_user]
    setup context do
      user_params = %{password: "abcdef", password_confirmation: "abcdef"}
      {:ok, %{user: user}} =UpdateUser.perform(context.user.id, user_params)

      [user: user, user_params: user_params]
    end

    test "should update user's password", %{user: user, user_params: params} do
      assert @bcrypt.checkpw(params.password, user.encrypted_password)
      assert @bcrypt.checkpw(params.password_confirmation, user.encrypted_password)
    end
  end

  describe "given user and only name to update" do
    setup [:create_user]
    setup context do
      user_params = %{name: "QueenBee"}
      {:ok, %{user: user}} = UpdateUser.perform(context.user.id, user_params)

      [user: user, user_params: user_params]
    end

    test "should update user's name", %{user: user, user_params: params} do
      assert user.name == params.name
    end
  end

  defp create_user(_) do
    [user: insert(:user)]
  end
end
