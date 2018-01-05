defmodule Subs.SubsNotification do
  @moduledoc false

  use Subs.Schema
  alias Subs.{User, SubsNotification, Subscription}

  schema "subs_notifications" do
    field(:status, NotificationStatusEnum)
    field(:type, SubsNotificationTypesEnum)
    field(:deliver_at, :naive_datetime)

    belongs_to :user, User
    belongs_to :notification, Notifier.Notification

    many_to_many :subscriptions, Subscription, join_through: "subs_notifications_subscriptions"

    timestamps()
  end

  @dt Application.get_env(:subs, :dt)
  @deliver_notifications_at Application.get_env(:subs, :deliver_notifications_at)

  @required_create_fields ~w(
    status
    type
    deliver_at
  )a

  def create_changeset(subscription) do
    params = %{
      status: :pending,
      type: :daily,
      deliver_at: @dt.step_date(subscription.next_bill_date, :hours, @deliver_notifications_at)
    }

    %SubsNotification{}
    |> cast(params, @required_create_fields)
    |> put_assoc(:user, subscription.user)
  end
end
