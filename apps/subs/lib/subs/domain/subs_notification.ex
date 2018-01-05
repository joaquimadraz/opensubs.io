defmodule Subs.SubsNotification do
  @moduledoc false

  use Subs.Schema
  alias Subs.{User, SubsNotification, Subscription}

  schema "subs_notifications" do
    field(:type, SubsNotificationTypesEnum)
    # TODO: Instead of sending all at 2AM, schedule for user's timezone
    field(:deliver_at, :naive_datetime)

    belongs_to :user, User
    belongs_to :notification, Notifier.Notification

    many_to_many :subscriptions, Subscription, join_through: "subs_notifications_subscriptions"

    timestamps()
  end

  @required_create_fields ~w(
    type
    deliver_at
  )a

  def create_changeset(user, params \\ %{}) do
    %SubsNotification{}
    |> cast(params, @required_create_fields)
    |> put_assoc(:user, user)
  end
end
