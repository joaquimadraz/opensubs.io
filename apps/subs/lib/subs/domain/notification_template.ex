defmodule Subs.Domain.NotificationTemplate do
  alias Subs.Helpers.Money

  defstruct [:title, :body]

  def create_daily_notification(_user, subscriptions) do
    count = Enum.count(subscriptions)

    title = "You have #{count} #{Inflex.inflect("payment", count)} due today"

    body = """
    Hello!

    Due today:
    #{Enum.map(subscriptions, &subscription_detail/1)}

    Thanks!
    """

    %__MODULE__{title: title, body: body}
  end

  defp subscription_detail(subscription) do
    "#{subscription.name} - #{Money.to_human_formated(subscription.amount, subscription.amount_currency)} \n"
  end
end
