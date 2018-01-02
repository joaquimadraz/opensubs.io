defmodule Subs.Test.UseCases.Subscriptions.FindUserSubscriptionsTest do
  use Subs.DataCase
  import Mox
  import Subs.Test.Support.Factory
  alias Subs.Helpers.DT
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

  test "returns user submissions with default current month stats", %{user: user} do
    insert(:complete_subscription, user_id: user.id, first_bill_date: ~N[2017-01-01T00:00:00Z])

    now = ~N[2049-01-01T00:00:00Z]

    Test.Subs.DTMock
    |> expect(:now, fn -> now end)
    |> expect(:step_date, 2, &DT.step_date/3)

    assert {:ok, %{
             month_stats: %{
               prev: %{
                 payments: [prev_payment]
               },
               curr: %{
                 payments: [curr_payment]
               },
               next: %{
                 payments: [next_payment]
               }
             }
           }} = FindUserSubscriptions.perform(user, %{}, Test.Subs.DTMock)

    assert prev_payment.current_bill_date == ~N[2048-12-01T00:00:00.000000]
    assert curr_payment.current_bill_date == ~N[2049-01-01T00:00:00.000000]
    assert next_payment.current_bill_date == ~N[2049-02-01T00:00:00.000000]
  end

  test "returns user submissions filtered by month/year", %{user: user} do
    insert(:complete_subscription, user_id: user.id, first_bill_date: ~N[1989-01-01T00:00:00Z])

    now = ~N[2018-01-01T00:00:00Z]

    Test.Subs.DTMock
    |> expect(:now, fn -> now end)
    |> expect(:step_date, 2, &DT.step_date/3)

    assert {:ok, %{
             month_stats: %{
               prev: %{
                 payments: [prev_payment]
               },
               curr: %{
                 payments: [curr_payment]
               },
               next: %{
                 payments: [next_payment]
               }
             }
           }} =
             FindUserSubscriptions.perform(
               user,
               %{"month_eq" => "8", "year_eq" => "1989"},
               Test.Subs.DTMock
             )

    assert prev_payment.current_bill_date == ~N[1989-07-01T00:00:00.000000]
    assert curr_payment.current_bill_date == ~N[1989-08-01T00:00:00.000000]
    assert next_payment.current_bill_date == ~N[1989-09-01T00:00:00.000000]
  end

  def includes_subscriptions?(subscriptions, should_include) do
    Enum.all?(subscriptions, fn subscription ->
      Enum.find(should_include, fn sub -> sub.id == subscription.id end)
    end)
  end
end
