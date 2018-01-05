defmodule Subs.Test.Application.DailyNotificationsBuilderTest do
  use Subs.DataCase
  import Mox
  import Subs.Test.Support.Factory
  alias Subs.Application.DailyNotificationsBuilder

  test "creates sub notification for specific day" do
    Test.Subs.DTMock
    |> expect(:now, 2, fn -> ~N[2018-01-01T00:00:00Z] end)
    |> expect(:beginning_of_day, fn _ -> ~N[2018-01-01T00:00:00Z] end)
    |> expect(:end_of_day, fn _ -> ~N[2018-01-01T23:59:59Z] end)

    user = insert(:user)

    subscription =
      insert(:complete_subscription, user: user, next_bill_date: ~N[2018-01-01T00:00:00Z])

    insert(:complete_subscription, user: user, next_bill_date: ~N[2018-01-02T00:00:00Z])

    [subs_notification] = DailyNotificationsBuilder.build(Test.Subs.DTMock)

    # Subs.SubsNotification was created for a particular user
    assert subs_notification.user_id == user.id
    assert subs_notification.type == :daily
    assert subs_notification.deliver_at == ~N[2018-01-01T00:00:00Z]

    # Notifier.Notification email was created for the user
    notification = subs_notification.notification
    assert notification.to == user.email
    assert notification.status == :pending
    assert notification.notify_at == ~N[2018-01-01T00:00:00Z]
    assert notification.title == "You have 1 payment due today"
    assert notification.body == "Hello!\n\nDue today:\nCustom Service - GBP7.00 \n\n\nThanks!\n"

    # Only the 2018-01-01 subscription was assigned for the notification
    [assigned_subscription] = subs_notification.subscriptions
    assert subscription.id == assigned_subscription.id
  end

  test "creates single notification with multiple subscriptions" do
    now = ~N[2018-01-01T00:00:00Z]

    Test.Subs.DTMock
    |> expect(:now, 2, fn -> now end)
    |> expect(:beginning_of_day, fn _ -> now end)
    |> expect(:end_of_day, fn _ -> ~N[2018-01-01T23:59:59Z] end)

    user = insert(:user)

    insert(:complete_subscription, name: "A", user: user, next_bill_date: now)
    insert(:complete_subscription, name: "B", user: user, next_bill_date: now)

    [%{notification: notification}] = DailyNotificationsBuilder.build(Test.Subs.DTMock)

    assert notification.title == "You have 2 payments due today"
    assert notification.body == "Hello!\n\nDue today:\nA - GBP7.00 \nB - GBP7.00 \n\n\nThanks!\n"
  end
end
