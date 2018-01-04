defmodule NotifierTest do
  use Notifier.DataCase

  alias Notifier.Notification
  import Notifier.Test.Support.Factory

  describe "create_notification" do
    test "creates a pending notification with default values" do
      to = "example@email.com"
      title = "Netflix is due tomorrow!"
      body = "Just a reminder that Netflix is due tomorrow!"
      notify_at = ~N[2018-01-01T09:00:00]

      {:ok, notification} = Notifier.create_notification(to, title, body, notify_at)

      assert %Notification{} = notification
      assert notification.id != nil
      assert notification.to == to
      assert notification.title == title
      assert notification.body == body
      assert notification.notify_at == notify_at
      assert notification.status == :pending
      assert notification.failure_reason == nil
      assert notification.try_deliver_at == nil
    end
  end
end
