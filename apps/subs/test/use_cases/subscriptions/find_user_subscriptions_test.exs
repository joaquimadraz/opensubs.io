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

  test "returns user submissions filtered by next bill date inclusively", %{user: user} do
    nov_sub =
      insert(:complete_subscription, %{next_bill_date: ~N[2018-11-01T00:00:00Z], user_id: user.id})

    end_nov_sub =
      insert(:complete_subscription, %{next_bill_date: ~N[2018-11-30T00:00:00Z], user_id: user.id})

    _dec_sub =
      insert(:complete_subscription, %{next_bill_date: ~N[2018-12-01T00:00:00Z], user_id: user.id})

    assert {:ok, %{subscriptions: user_subscriptions}} =
             FindUserSubscriptions.perform(user, %{
               "next_bill_date_gte" => "2018-10-01",
               "next_bill_date_lte" => "2018-10-31"
             })

    assert Enum.count(user_subscriptions) == 0

    assert {:ok, %{subscriptions: [first, second]}} =
             FindUserSubscriptions.perform(user, %{
               "next_bill_date_gte" => "2018-11-01",
               "next_bill_date_lte" => "2018-11-30"
             })

    assert first.id == nov_sub.id
    assert second.id == end_nov_sub.id
  end

  def includes_subscriptions?(subscriptions, should_include) do
    Enum.all?(subscriptions, fn subscription ->
      Enum.find(should_include, fn sub -> sub.id == subscription.id end)
    end)
  end
end
