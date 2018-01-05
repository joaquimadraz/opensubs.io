defmodule Subs.Test.Application.DailyNotificationsBuilderTest do
  use Subs.DataCase
  import Mox
  import Subs.Test.Support.Factory
  alias Subs.Application.DailyNotificationsBuilder

  setup do
    now = ~N[2018-01-01T00:00:00Z]

    Test.Subs.DTMock
    |> expect(:now, 3, fn -> now end)
    |> expect(:beginning_of_day, fn _ -> now end)
    |> expect(:end_of_day, fn _ -> ~N[2018-01-01T23:59:59Z] end)

    [now: now]
  end

  test "creates sub notification for specific day", %{now: now} do
    user = insert(:user)

    subscription = insert(:complete_subscription, user: user, next_bill_date: now)

    insert(:complete_subscription, user: user, next_bill_date: ~N[2018-01-02T00:00:00Z])

    [subs_notification] = DailyNotificationsBuilder.build(Test.Subs.DTMock)

    # Subs.SubsNotification was created for a particular user
    assert subs_notification.user_id == user.id
    assert subs_notification.type == :daily
    assert subs_notification.deliver_at == now

    # Notifier.Notification email was created for the user
    notification = subs_notification.notification
    assert notification.to == user.email
    assert notification.status == :pending
    assert notification.notify_at == now
    assert notification.title == "You have 1 payment due today"
    assert notification.body == "Hello!\n\nDue today:\nCustom Service - GBP7.00 \n\n\nThanks!\n"

    # Only the 2018-01-01 subscription was assigned for the notification
    [assigned_subscription] = subs_notification.subscriptions
    assert subscription.id == assigned_subscription.id
  end

  test "creates single notifier.notification with multiple subscriptions", %{now: now} do
    user = insert(:user)

    insert(:complete_subscription, name: "A", user: user, next_bill_date: now)
    insert(:complete_subscription, name: "B", user: user, next_bill_date: now)

    [%{notification: notification}] = DailyNotificationsBuilder.build(Test.Subs.DTMock)

    assert notification.title == "You have 2 payments due today"
    assert notification.body == "Hello!\n\nDue today:\nA - GBP7.00 \nB - GBP7.00 \n\n\nThanks!\n"
  end

  test "creates multiple sub notifications for different users", %{now: now} do
    user_a = insert(:user, email: "a@email.com")
    user_b = insert(:user, email: "b@email.com")

    insert(:complete_subscription, name: "A", user: user_a, next_bill_date: now)
    insert(:complete_subscription, name: "B", user: user_b, next_bill_date: now)

    [%{notification: notification_a}, %{notification: notification_b}] =
      DailyNotificationsBuilder.build(Test.Subs.DTMock)

    assert notification_a.to == user_a.email
    assert notification_b.to == user_b.email
  end

  test "creates sub notification and updates monthly subscription next_bill_date", %{now: now} do
    user = insert(:user)

    insert(:complete_subscription, cycle: "monthly", user: user, next_bill_date: now)

    [%{subscriptions: [subscription]}] = DailyNotificationsBuilder.build(Test.Subs.DTMock)

    assert subscription.next_bill_date == ~N[2018-02-01T00:00:00.000000]
  end

  test "creates sub notification and updates yearly subscription next_bill_date", %{now: now} do
    user = insert(:user)

    insert(:complete_subscription, cycle: "yearly", user: user, next_bill_date: now)

    [%{subscriptions: [subscription]}] = DailyNotificationsBuilder.build(Test.Subs.DTMock)

    assert subscription.next_bill_date == ~N[2019-01-01T00:00:00.000000]
  end
end
