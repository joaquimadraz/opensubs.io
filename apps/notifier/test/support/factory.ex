defmodule Notifier.Test.Support.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Notifier.Repo
  alias Notifier.Notification

  def pending_notification_factory do
    %Notification{
      to: "example@email.com",
      title: "Netflix is due tomorrow!",
      body: "Just a reminder that Netflix is due tomorrow!",
      notify_at: ~N[2018-01-01T09:00:00],
      status: :pending,
      failure_reason: nil,
      try_deliver_at: nil
    }
  end

  def delivered_notification_factory do
    %Notification{
      to: "example@email.com",
      title: "Netflix is due tomorrow!",
      body: "Just a reminder that Netflix is due tomorrow!",
      notify_at: ~N[2018-01-01T09:00:00],
      status: :delivered,
      failure_reason: nil,
      try_deliver_at: ~N[2018-01-02T00:00:00],
    }
  end

  def failed_notification_factory do
    %Notification{
      to: "example@email.com",
      title: "Netflix is due tomorrow!",
      body: "Just a reminder that Netflix is due tomorrow!",
      notify_at: ~N[2018-01-01T09:00:00],
      status: :failed,
      failure_reason: "STMP failure",
      try_deliver_at: ~N[2018-01-02T00:00:00],
    }
  end
end
