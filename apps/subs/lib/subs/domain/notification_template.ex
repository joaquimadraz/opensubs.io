defmodule Subs.Domain.NotificationTemplate do
  alias Subs.Helpers.Money
  alias Subs.Subscription

  @dt Application.get_env(:subs, :dt)

  defstruct [:title, :body]

  # TODO: Refactor, this module is awfull. What have I done!?
  def build(:daily, subscriptions, _date \\ @dt.now()) do
    yearly_payments = Enum.filter(subscriptions, &Subscription.yearly?/1)
    monthly_payments = Enum.filter(subscriptions, &Subscription.monthly?/1)

    title = build_title(:daily, yearly_payments, monthly_payments) |> freeze()

    message =
      []
      |> append_greeting()
      |> append_new_line(2)
      |> append_yearly_payments(yearly_payments)
      |> append_new_line_between_payments(yearly_payments, monthly_payments)
      |> append_monthly_payments(monthly_payments)
      |> append_total(subscriptions)
      |> append_new_line(3)
      |> append_good_bye()
      |> freeze("\n")

    %__MODULE__{title: title, body: message}
  end

  def build(:weekly, subscriptions, _date) do
    yearly_payments = Enum.filter(subscriptions, &Subscription.yearly?/1)
    monthly_payments = Enum.filter(subscriptions, &Subscription.monthly?/1)

    title = build_title(:weekly, yearly_payments, monthly_payments) |> freeze()

    message =
      []
      |> append_greeting()
      |> append_new_line(2)
      |> append_weekly_title()
      |> append_payments(subscriptions, :full)
      |> append_new_line(3)
      |> append_good_bye()
      |> freeze("\n")

    %__MODULE__{title: title, body: message}
  end

  def build(:monthly, subscriptions, date) do
    title = build_title(:monthly, date) |> freeze()

    message =
      []
      |> append_greeting()
      |> append_new_line(2)
      |> append_monthly_total(subscriptions)
      |> append_new_line(2)
      |> append_monthly_title(subscriptions)
      |> append_payments(subscriptions, :detail)
      |> append_new_line(3)
      |> append_good_bye()
      |> freeze("\n")

    %__MODULE__{title: title, body: message}
  end

  defp build_title(:monthly, date) do
    ["Your payments for ", [@dt.strftime(date, "%B %Y")]]
  end

  def build_title(:weekly, yearly_payments, monthly_payments) do
    [build_payments_title(yearly_payments, monthly_payments), ["next week"]]
  end

  def build_title(:daily, yearly_payments, monthly_payments) do
    [build_payments_title(yearly_payments, monthly_payments), ["tomorrow"]]
  end

  defp build_payments_title([], [monthly_payment]) do
    [monthly_payment.name, [" is due "]]
  end

  defp build_payments_title([], [monthly_payment | [another_monthly_payment]]) do
    [monthly_payment.name, [" and ", [another_monthly_payment.name, [" are due "]]]]
  end

  defp build_payments_title([], monthly_payments) do
    count = Enum.count(monthly_payments)

    [Integer.to_string(count), [" payments are due "]]
  end

  defp build_payments_title([yearly_payment], _) do
    [yearly_payment.name, [" is due "]]
  end

  defp build_payments_title(yearly_payments, _) do
    count = Enum.count(yearly_payments)

    [Integer.to_string(count), [" yearly payments are due "]]
  end

  defp append_weekly_title(message) do
    [message, ["Here are your payments for next week:"]]
  end

  defp append_monthly_total(message, subscriptions) do
    currency_symbol = "£"
    total = Enum.reduce(subscriptions, 0.0, fn subscription, acc -> acc + subscription.amount end)

    [message, ["Next month you are spending ", Money.to_human_formated(total, currency_symbol)]]
  end

  defp append_monthly_title(message, subscriptions) do
    count = Enum.count(subscriptions)
    payments = Inflex.inflect("payment", count)
    are = if count > 1, do: " are ", else: " is "

    [message, ["Here", are, "your ", payments, " for next month:"]]
  end

  defp append_greeting(message), do: message ++ ["Hello,"]

  defp append_new_line(message, count \\ 1) do
    [message, Enum.map(0..(count - 1), fn _ -> "\n" end)]
  end

  defp append_new_line_between_payments(message, [], _), do: message
  defp append_new_line_between_payments(message, _, []), do: message

  defp append_new_line_between_payments(message, _, _) do
    append_new_line(message, 2)
  end

  defp append_yearly_payments(message, []), do: message

  defp append_yearly_payments(message, subscriptions) do
    count = Enum.count(subscriptions)

    message
    |> append_yearly_header(count)
    |> append_payments(subscriptions)
  end

  defp append_yearly_header(message, count) do
    payments = Inflex.inflect("payment", count)
    are = if count > 1, do: " are ", else: " is "

    [message, [Integer.to_string(count), [" yearly ", [payments, [are, ["due tomorrow:"]]]]]]
  end

  defp append_monthly_payments(message, []), do: message

  defp append_monthly_payments(message, subscriptions) do
    count = Enum.count(subscriptions)

    message
    |> append_monthly_header(count)
    |> append_payments(subscriptions)
  end

  defp append_monthly_header(message, count) do
    payments = Inflex.inflect("payment", count)
    are = if count > 1, do: " are ", else: " is "

    [message, [Integer.to_string(count), [" monthly ", [payments, [are, ["due tomorrow:"]]]]]]
  end

  defp append_payments(message, subscriptions, view \\ :compact) do
    [message, Enum.map(subscriptions, &subscription_detail(&1, view))]
  end

  defp append_total(message, [_subscription]), do: message

  defp append_total(message, subscriptions) do
    currency_symbol = "£"
    total = Enum.reduce(subscriptions, 0.0, fn subscription, acc -> acc + subscription.amount end)

    [message, ["\n", ["\n", ["\n", ["Total - ", [Money.to_human_formated(total, currency_symbol)]]]]]]
  end

  defp append_good_bye(message) do
    [message, ["See you later,", ["\n", ["Subs"]]]]
  end

  defp subscription_detail(subscription, :full) do
    human_date = @dt.strftime(subscription.next_bill_date, "(%F)")

    if NaiveDateTime.to_date(@dt.now()) == NaiveDateTime.to_date(subscription.next_bill_date) do
      [subscription_detail(subscription, :compact), ", is due tomorrow ", human_date]
    else
      weekday = @dt.strftime(subscription.next_bill_date, "%A")
      [subscription_detail(subscription, :compact), ", is due on ", weekday, " ", human_date]
    end
  end

  defp subscription_detail(subscription, :detail) do
    human_date = @dt.strftime(subscription.next_bill_date, "%F")

    [subscription_detail(subscription, :compact), ", ", human_date]
  end

  defp subscription_detail(subscription, :compact) do
    currency_symbol = "£"

    [
      "\n",
      [
        subscription.name,
        [" - ", [Money.to_human_formated(subscription.amount, currency_symbol)]]
      ]
    ]
  end

  defp freeze(message) do
    List.to_string(message)
  end

  defp freeze(message, ending) do
    List.to_string([message, ending])
  end
end
