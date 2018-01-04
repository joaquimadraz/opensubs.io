defmodule Notifier.NotificationDelivererTest do
  use Notifier.DataCase

  import Mox
  import Notifier.Test.Support.Factory
  alias Notifier.NotificationDeliverer

  defmodule FailureMailerMock do
    def safe_deliver(email = %{subject: "success"}), do: {:ok, email}
    def safe_deliver(%{subject: "smtp_failure"}), do: {:error, :smtp_error, "Provider failed"}
    def safe_deliver(%{subject: "unknown_failure"}), do: {:error, :unable_to_deliver, "Something failed"}
  end

  test "fails to deliver a notification from smtp error" do
    now = ~N[2018-01-02T00:00:00]
    notification = insert(:pending_notification, title: "smtp_failure")
    expect(Notifier.DTMock, :now, fn -> now end)

    {:error, notification} = NotificationDeliverer.deliver(notification, FailureMailerMock, Notifier.DTMock)
    assert notification.status == :failed
    assert notification.try_deliver_at == now
    assert notification.failure_reason == "SMTP_ERROR: Provider failed"
  end
end
