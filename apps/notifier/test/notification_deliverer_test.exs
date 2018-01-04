defmodule Notifier.NotificationDelivererTest do
  use Notifier.DataCase

  import Mox
  import Notifier.Test.Support.Factory
  alias Notifier.NotificationDeliverer

  defmodule MailerMock do
    def safe_deliver(%{subject: "smtp_failure"}), do: {:error, :smtp_error, "Provider failed"}
    def safe_deliver(%{subject: "unknown_failure"}), do: {:error, :unable_to_deliver, "Something failed"}
    def safe_deliver(email), do: {:ok, email}
  end

  test "fails to deliver a notification from smtp error" do
    now = ~N[2018-01-02T00:00:00]
    notification = insert(:pending_notification, title: "smtp_failure")
    expect(Notifier.DTMock, :now, fn -> now end)

    {:error, notification} = NotificationDeliverer.deliver(notification, MailerMock, Notifier.DTMock)
    assert notification.status == :failed
    assert notification.try_deliver_at == now
    assert notification.failure_reason == "SMTP_ERROR: Provider failed"
  end

  test "fails to deliver a notification from unknown error" do
    now = ~N[2018-01-02T00:00:00]
    notification = insert(:pending_notification, title: "unknown_failure")
    expect(Notifier.DTMock, :now, fn -> now end)

    {:error, notification} = NotificationDeliverer.deliver(notification, MailerMock, Notifier.DTMock)
    assert notification.status == :failed
    assert notification.try_deliver_at == now
    assert notification.failure_reason == "UNKNOWN_ERROR: Something failed"
  end

  test "deliver the notification" do
    now = ~N[2018-01-02T00:00:00]
    notification = insert(:pending_notification)
    expect(Notifier.DTMock, :now, fn -> now end)

    {:ok, notification} = NotificationDeliverer.deliver(notification, MailerMock, Notifier.DTMock)
    assert notification.status == :delivered
    assert notification.try_deliver_at == now
    assert notification.failure_reason == nil
  end
end
