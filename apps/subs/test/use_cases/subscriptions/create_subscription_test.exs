defmodule Subs.Test.UseCases.Subscriptions.CreateSubscriptionTest do
  use Subs.DataCase
  import Subs.Test.Support.Factory

  alias Subs.UseCases.Subscriptions.CreateSubscription

  test "returns error for missing required params" do
    {:error, {error, %{changeset: changeset}}} = CreateSubscription.perform(%{})

    assert error == :invalid_params
    assert {"can't be blank", _} = changeset.errors[:name]
  end

  test "returns error for invalid params" do
    params = string_params_for(:subscription, amount: -1)
    {:error, {error, %{changeset: changeset}}} = CreateSubscription.perform(params)

    assert error == :invalid_params
    assert {"must be greater than %{number}", _} = changeset.errors[:amount]
  end

  test "creates subscription" do
    params = string_params_for(:subscription)

    assert {:ok, %{subscription: subscription}} = CreateSubscription.perform(params)
    assert subscription.id != nil
  end

  test "consolidates amount as integer value" do
    params = string_params_for(:subscription, amount: 7.99)

    assert {:ok, %{subscription: subscription}} = CreateSubscription.perform(params)
    assert subscription.amount == 799
  end

  test "consolidates valid string amount value" do
    params = string_params_for(:subscription, amount: 2.50)
    assert {:ok, %{subscription: subscription}} = CreateSubscription.perform(params)
    assert subscription.amount == 250
  end

  test "consolidates valid integer amount value" do
    params = string_params_for(:subscription, amount: 50)
    assert {:ok, %{subscription: subscription}} = CreateSubscription.perform(params)
    assert subscription.amount == 5000
  end

  test "returns error for invalid amount value" do
    params = string_params_for(:subscription, amount: "hey")
    {:error, {error, %{changeset: changeset}}} = CreateSubscription.perform(params)

    assert error == :invalid_params
    assert {"is invalid", _} = changeset.errors[:amount]
  end
end
