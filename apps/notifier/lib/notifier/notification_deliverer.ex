defmodule Notifier.NotificationDeliverer do
  alias Notifier.{DT, NotificationRepo}

  def deliver(notification, dt \\ DT) do
    {:ok, _notification} = NotificationRepo.deliver(notification, dt)
  end
end
