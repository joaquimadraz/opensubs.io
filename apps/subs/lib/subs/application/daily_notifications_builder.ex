defmodule Subs.Application.DailyNotificationsBuilder do
  alias Subs.{SubscriptionRepo, SubsNotificationRepo}
  alias Subs.Domain.NotificationTemplate
  alias Repository.Repo

  @dt Application.get_env(:subs, :dt)

  def build(dt \\ @dt) do
    now = dt.now()
    from = dt.beginning_of_day(now)
    to = dt.end_of_day(now)

    case SubscriptionRepo.get_billable_subscriptions(from, to) do
      [] -> :noop
      subscriptions ->
        # TODO: Group subscriptions by user an create a notification for each.
        user = Repo.preload(List.first(subscriptions), :user).user

        template = NotificationTemplate.create_daily_notification(user, subscriptions)

        case SubsNotificationRepo.create(user, subscriptions, template, dt) do
          {:ok, subs_notification} -> [subs_notification]
        end
    end
  end
end
