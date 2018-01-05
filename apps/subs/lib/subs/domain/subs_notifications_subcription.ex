defmodule Subs.SubsNotificationsSubscription do
  @moduledoc false

  use Subs.Schema
  alias Subs.{SubsNotification, Subscription}

  schema "subs_notifications_subscriptions" do
    belongs_to :subs_notification, SubsNotification
    belongs_to :subscription, Subscription

    timestamps()
  end
end
