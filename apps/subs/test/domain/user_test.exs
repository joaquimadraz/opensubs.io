defmodule Subs.Test.Domain.UserTest do
  use ExUnit.Case
  alias Subs.User
  import Mox
  import Subs.Test.Support.Factory

  describe "given user params" do
    setup [:build_params]

    setup(context) do
      Map.merge(%{user: create_user(context.params)}, context)
    end

    test "should encrypt password", %{user: user} do
      encrypted_password = Ecto.Changeset.get_change(user, :encrypted_password)

      assert encrypted_password != nil
      assert String.length(encrypted_password) > 0
    end

    test "confirmation_token is set", %{user: user} do
      confirmation_token = Ecto.Changeset.get_change(user, :confirmation_token)
      assert confirmation_token != nil
    end
  end

  describe "given an multi cased email" do
    setup [:build_params]

    test "should format email", %{params: params} do
      params = %{params | "email" => "bEe@EMAIL.com"}

      email =
        params
        |> create_user
        |> Ecto.Changeset.get_change(:email)

      assert email == String.downcase(params["email"])
    end
  end

  describe "given an invalid email" do
    setup [:build_params]

    test "should return error for invalid email", %{params: params} do
      params = %{params | "email" => "invalid"}
      user = create_user(params)
      {message, _} = user.errors[:email]

      assert message == "has invalid format"
    end
  end

  describe "#recover_password_changeset" do
    test "populates necessary fields to recover password" do
      now = ~N[2017-11-06 21:00:00]
      will_expire_at = ~N[2017-11-06 21:00:00]

      Test.Subs.DTMock
      |> expect(:now, fn() -> now end)
      |> expect(:step_date, fn(now, :hours, 1) -> will_expire_at end)

      user = build(:user)
      changeset = User.recover_password_changeset(user, Test.Subs.DTMock)

      expires_at = Ecto.Changeset.get_change(changeset, :password_recovery_expires_at)
      token = Ecto.Changeset.get_change(changeset, :password_recovery_token)

      assert expires_at == will_expire_at
      assert token != nil
    end
  end

  def create_user(params) do
    User.create_changeset(%User{}, params)
  end

  def build_params(_) do
    [params: string_params_for(:user)]
  end
end
