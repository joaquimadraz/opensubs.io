defmodule Subs.Test.UseCases.Users.CreateUserTest do
  use Subs.DataCase
  import Subs.Test.Support.Factory

  alias Subs.UseCases.Users.CreateUser

  describe "given user params" do
    setup do
      user_params = params_for(:user)
      {:ok, %{user: user}} = CreateUser.perform(user_params)

      [user: user, user_params: user_params]
    end

    test "should create user user", %{user: user, user_params: params} do
      assert user.id != nil
      assert user.name == params[:name]
    end

    test "should encrypt password", %{user: user} do
      assert user.encrypted_password != nil
      assert String.length(user.encrypted_password) > 0
    end
  end

  describe "given an invalid email" do
    setup do
      {:error, {:invalid_params, not_created}} =
        CreateUser.perform(params_for(:user, email: "invalid"))

      not_created
    end

    test "should return error for invalid email", %{changeset: changeset} do
      {message, _} = changeset.errors[:email]
      assert message == "has invalid format"
    end
  end

  describe "given an multi cased email" do
    setup do
      user_params = params_for(:user, email: "bEe@EMAIL.com")
      {:ok, %{user: user}} = CreateUser.perform(user_params)

      [user: user, user_params: user_params]
    end

    test "should create with email downcased", %{user: user, user_params: params} do
      assert user.email == String.downcase(params[:email])
    end
  end

  describe "given a duplicated email" do
    setup do
      user_params = params_for(:user)
      {:ok, _} = CreateUser.perform(user_params)
      {:error, {:invalid_params, not_created}} = CreateUser.perform(user_params)

      not_created
    end

    test "should return error for duplicated email", %{changeset: changeset} do
      {message, _} = changeset.errors[:email]
      assert message == "has already been taken"
    end
  end

  describe "given only password" do
    setup do
      {:error, {:invalid_params, not_created}} = CreateUser.perform(%{
        password: "abcdef"
      })

      not_created
    end

    test "should return error for missing password_confirmation", %{changeset: changeset} do
      {message, _} = changeset.errors[:password_confirmation]
      assert message == "can't be blank"
    end
  end

  describe "given not matching password/password_confirmation" do
    setup do
      {:error, {:invalid_params, not_created}} = CreateUser.perform(%{
        password: "abcdef",
        password_confirmation: "bcdefg"
      })

      not_created
    end

    test "should return error for not matching password_confirmation/password",
         %{changeset: changeset} do
      {message, _} = changeset.errors[:password_confirmation]
      assert message == "does not match confirmation"
    end
  end
end
