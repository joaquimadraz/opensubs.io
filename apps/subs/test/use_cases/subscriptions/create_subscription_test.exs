defmodule Subs.Test.UseCases.Subscriptions.CreateSubscriptionTest do
  use Subs.DataCase
  import Subs.Test.Support.Factory
  alias Subs.UseCases.Subscriptions.CreateSubscription

  setup do
    [user: insert(:user)]
  end

  test "returns error for missing required params", %{user: user} do
    {:error, {error, %{changeset: changeset}}} = CreateSubscription.perform(user, %{})

    assert error == :invalid_params
    assert {"can't be blank", _} = changeset.errors[:name]
  end

  test "returns error for invalid params", %{user: user} do
    params = string_params_for(:subscription, amount: -1)
    {:error, {error, %{changeset: changeset}}} = CreateSubscription.perform(user, params)

    assert error == :invalid_params
    assert {"must be greater than %{number}", _} = changeset.errors[:amount]
  end

  test "creates subscription", %{user: user} do
    params = string_params_for(:subscription)

    assert {:ok, %{subscription: subscription}} = CreateSubscription.perform(user, params)
    assert subscription.id != nil
    assert subscription.user_id == user.id
  end

  test "consolidates amount as integer value", %{user: user} do
    params = string_params_for(:subscription, amount: 7.99)

    assert {:ok, %{subscription: subscription}} = CreateSubscription.perform(user, params)
    assert subscription.amount == 799
  end

  test "consolidates valid string amount value", %{user: user} do
    params = string_params_for(:subscription, amount: "2.50")
    assert {:ok, %{subscription: subscription}} = CreateSubscription.perform(user, params)
    assert subscription.amount == 250
  end

  test "consolidates valid integer amount value", %{user: user} do
    params = string_params_for(:subscription, amount: 50)
    assert {:ok, %{subscription: subscription}} = CreateSubscription.perform(user, params)
    assert subscription.amount == 5000
  end

  test "returns error for invalid amount value", %{user: user} do
    params = string_params_for(:subscription, amount: "hey")
    {:error, {error, %{changeset: changeset}}} = CreateSubscription.perform(user, params)

    assert error == :invalid_params
    assert {"is invalid", _} = changeset.errors[:amount]
  end
end
