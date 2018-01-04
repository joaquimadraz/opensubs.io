defmodule NotifierTest do
  use Notifier.DataCase

  import Mox
  import Notifier.Test.Support.Factory
  alias Notifier.Notification

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

  describe "deliver" do
    test "returns no delivered notification when no pending notifications exist" do
      assert {:ok, []} = Notifier.deliver_notifications()
    end

    test "returns delivered notification" do
      insert(:failed_notification)
      insert(:delivered_notification)
      pending = insert(:pending_notification)
      now = ~N[2018-01-02T00:00:00]

      expect(Notifier.DTMock, :now, fn -> now end)

      assert {:ok, [delivered]} = Notifier.deliver_notifications(Notifier.DTMock)

      assert delivered.id == pending.id
      assert delivered.status == :delivered
      assert delivered.try_deliver_at == now
    end
  end
end
