defmodule Subs.Test.Application.SubscriptionsByMonthTest do
  use Subs.DataCase
  import Subs.Test.Support.Factory
  alias Subs.Application.SubscriptionsByMonth

  test "returns no subscriptions" do
    [] = SubscriptionsByMonth.filter([], 10, 2017)
  end

  describe "given monthly and yearly subscriptions" do
    setup do
      user = insert(:user)

      yearly_sub =
        insert(
          :complete_subscription,
          user: user,
          name: "A",
          cycle: "yearly",
          first_bill_date: ~N[2017-09-01 00:00:00]
        )

      monthly_sub =
        insert(
          :complete_subscription,
          user: user,
          name: "B",
          cycle: "monthly",
          first_bill_date: ~N[2017-10-01 00:00:00]
        )

      [yearly_sub: yearly_sub, monthly_sub: monthly_sub, all: [yearly_sub, monthly_sub]]
    end

    test "returns subscriptions for given month with given month bill date", %{
      monthly_sub: monthly_sub,
      all: all
    } do
      [subscription] = SubscriptionsByMonth.filter(all, 12, 2017)

      assert subscription.id == monthly_sub.id
      assert subscription.current_bill_date == ~N[2017-12-01 00:00:00]

      [subscription] = SubscriptionsByMonth.filter(all, 1, 2018)

      assert subscription.id == monthly_sub.id
      assert subscription.current_bill_date == ~N[2018-01-01 00:00:00]
    end

    test "returns yearly and monthly subscriptions in month", %{
      yearly_sub: yearly_sub,
      monthly_sub: monthly_sub,
      all: all
    } do
      [subscription] = SubscriptionsByMonth.filter(all, 9, 2017)

      assert subscription.id == yearly_sub.id
      assert subscription.current_bill_date == ~N[2017-09-01 00:00:00]

      [yearly, monthly] = SubscriptionsByMonth.filter(all, 9, 2018)

      assert yearly.id == yearly_sub.id
      assert yearly.current_bill_date == ~N[2018-09-01 00:00:00]

      assert monthly.id == monthly_sub.id
      assert monthly.current_bill_date == ~N[2018-09-01 00:00:00]
    end

    test "return monthly february subscriptions" do
      monthly_feb =
        insert(
          :complete_subscription,
          user: insert(:user),
          cycle: "monthly",
          first_bill_date: ~N[2016-02-29 00:00:00]
        )

      [subscription] = SubscriptionsByMonth.filter([monthly_feb], 2, 2018)

      assert subscription.current_bill_date == ~N[2018-02-28 00:00:00]

      [subscription] = SubscriptionsByMonth.filter([monthly_feb], 2, 2020)

      assert subscription.current_bill_date == ~N[2020-02-29 00:00:00]
    end

    test "return yearly february subscriptions" do
      yearly_feb =
        insert(
          :complete_subscription,
          user: insert(:user),
          cycle: "yearly",
          first_bill_date: ~N[2016-02-28 00:00:00]
        )

      [subscription] = SubscriptionsByMonth.filter([yearly_feb], 2, 2018)

      assert subscription.current_bill_date == ~N[2018-02-28 00:00:00]
    end
  end

  test "sorts subscriptions by generated current_bill_date" do
    user = insert(:user)

    sub_x =
      insert(
        :complete_subscription,
        user: user,
        name: "X",
        cycle: "monthly",
        first_bill_date: ~N[2017-12-10 00:00:00]
      )

    sub_y =
      insert(
        :complete_subscription,
        user: user,
        name: "Y",
        cycle: "monthly",
        first_bill_date: ~N[2016-08-02 00:00:00]
      )

    sub_z =
      insert(
        :complete_subscription,
        user: user,
        name: "Z",
        cycle: "monthly",
        first_bill_date: ~N[2017-10-03 00:00:00]
      )

    [%{name: "Y"} | [%{name: "Z"} | [%{name: "X"}]]] =
      SubscriptionsByMonth.filter([sub_x, sub_y, sub_z], 1, 2018)
  end
end
