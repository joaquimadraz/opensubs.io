defmodule Subs.Test.Application.DailyNotificationsBuilderTest do
  use Subs.DataCase
  import Mox
  import Subs.Test.Support.Factory
  alias Subs.Application.DailyNotificationsBuilder

  test "creates sub notification for specific day" do
    Test.Subs.DTMock
    |> expect(:now, fn -> ~N[2018-01-01T00:00:00Z] end)
    |> expect(:beginning_of_day, fn _ -> ~N[2018-01-01T00:00:00Z] end)
    |> expect(:end_of_day, fn _ -> ~N[2018-01-01T23:59:59Z] end)

    user = insert(:user)

    subscription =
      insert(
        :complete_subscription,
        user: user,
        first_bill_date: ~N[2017-12-01T00:00:00Z],
        next_bill_date: ~N[2018-01-01T00:00:00Z]
      )

    insert(
      :complete_subscription,
      user: user,
      first_bill_date: ~N[2017-12-01T00:00:00Z],
      next_bill_date: ~N[2018-01-02T00:00:00Z]
    )

    [subs_notification] = DailyNotificationsBuilder.build(Test.Subs.DTMock)

    # Subs.SubsNotification was created for a particular user
    assert subs_notification.user_id == user.id
    assert subs_notification.status == :pending
    assert subs_notification.type == :daily
    assert subs_notification.deliver_at == ~N[2018-01-01T02:00:00Z]

    # Notifier.Notification email was created for the user
    notification = subs_notification.notification
    assert notification.to == user.email
    assert notification.status == :pending
    assert notification.notify_at == ~N[2018-01-01T02:00:00Z]

    # Only the 2018-01-01 subscription was assigned for the notification
    [assigned_subscription] = subs_notification.subscriptions
    assert subscription.id == assigned_subscription.id
  end
end
