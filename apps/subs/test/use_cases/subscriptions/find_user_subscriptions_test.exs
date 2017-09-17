defmodule Subs.Test.UseCases.Subscriptions.FindUserSubscriptionsTest do
  use Subs.DataCase
  import Subs.Test.Support.Factory
  alias Subs.UseCases.Subscriptions.FindUserSubscriptions

  setup do
    [user: insert(:user)]
  end

  test "returns no user subscriptions", %{user: user} do
    insert_list(10, :complete_subscription, %{user_id: insert(:user).id})

    assert {:ok, %{subscriptions: subscriptions}} = FindUserSubscriptions.perform(user)
    assert Enum.count(subscriptions) == 0
  end

  test "returns user subscriptions", %{user: user} do
    subscriptions = insert_list(10, :complete_subscription, %{user_id: user.id})

    assert {:ok, %{subscriptions: user_subscriptions}} = FindUserSubscriptions.perform(user)
    assert Enum.count(user_subscriptions) == 10
    assert includes_subscriptions?(user_subscriptions, subscriptions)
  end

  test "return user subsmissions except archived", %{user: user} do
    completed = insert_list(5, :complete_subscription, %{user_id: user.id})
    archived = insert_list(5, :archived_subscription, %{user_id: user.id})

    assert {:ok, %{subscriptions: user_subscriptions}} = FindUserSubscriptions.perform(user)
    assert Enum.count(user_subscriptions) == 5
    assert includes_subscriptions?(user_subscriptions, completed)
    assert !includes_subscriptions?(user_subscriptions, archived)
  end

  def includes_subscriptions?(subscriptions, should_include) do
    Enum.all?(subscriptions, fn(subscription) ->
      Enum.find(should_include, fn(sub) -> sub.id == subscription.id end)
    end)
  end
end
