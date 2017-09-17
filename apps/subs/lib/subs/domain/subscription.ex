defmodule Subs.Subscription do
  @moduledoc false

  use Subs.Schema
  alias Subs.User
  alias Subs.Helpers.Money

  schema "subscriptions" do
    field :name, :string
    field :description, :string
    field :amount, :integer
    field :amount_currency
    field :amount_currency_symbol
    field :cycle, :string
    field :color, :string
    field :first_bill_date, :naive_datetime
    field :next_bill_date, :naive_datetime

    belongs_to :user, User

    timestamps()
  end

  @required_create_fields ~w(
    name
    amount
    amount_currency
    cycle
    user_id
  )a

  @optional_fields ~w(
    color
    description
    first_bill_date
  )a

  @required_updated_fields ~w(
    name
    amount
    amount_currency
    cycle
  )a

  @updatable_fields ~w(
    name
    description
    amount
    amount_currency
    cycle
    color
    first_bill_date
  )

  @currency_codes ~w(EUR GBP USD)
  @cycles ~w(monthly yearly)
  @default_color "#E2E2E2"

  def build_with_user(user, params) do
    user
    |> build_assoc(:subscriptions)
    |> create_changeset(params)
  end

  def create_changeset(struct, params \\ %{}) do
    params = consolidate_amount(params)

    struct
    |> cast(params, @required_create_fields ++ @optional_fields)
    |> validate_required(@required_create_fields)
    |> foreign_key_constraint(:user_id)
    |> validate_subscription()
  end

  def update_changeset(struct, params \\ %{}) do
    params = consolidate_amount(params)

    struct
    |> cast(params, @updatable_fields)
    |> validate_required(@required_updated_fields)
    |> validate_subscription()
  end

  defp validate_subscription(changeset) do
    changeset
    |> validate_number(:amount, greater_than: 0)
    |> validate_inclusion(:amount_currency, @currency_codes, message: "unknown currency")
    |> validate_inclusion(:cycle, @cycles, message: "must be one of: monthly, yearly")
    |> validate_format(:color, ~r/^#(?:[0-9a-fA-F]{3}){1,2}$/, message: "invalid format, must be HEX format, ex: #FF0000")
    |> sanitize_color()
    |> sanitize_amount_currency()
    |> populate_first_bill_date()
    |> populate_next_bill_date()
  end

  defp sanitize_color(changeset) do
    case get_change(changeset, :color) do
      nil -> put_change(changeset, :color, @default_color)
      value -> put_change(changeset, :color, String.upcase(value))
    end
  end

  defp sanitize_amount_currency(changeset) do
    case get_change(changeset, :amount_currency) do
      nil -> changeset
      value ->
        amount_currency = String.upcase(value)

        changeset
        |> put_change(:amount_currency, amount_currency)
        |> put_change(:amount_currency_symbol, currency_symbol(amount_currency))
    end
  end

  defp populate_first_bill_date(changeset = %{valid?: false}), do: changeset
  defp populate_first_bill_date(changeset) do
    case get_change(changeset, :first_bill_date) do
      nil ->
        put_change(changeset, :first_bill_date, today_beginning_of_day())
        _ ->
        changeset
    end
  end

  # TODO: Rafactor, case -> pattern matching
  defp populate_next_bill_date(changeset = %{valid?: false}), do: changeset
  defp populate_next_bill_date(changeset) do
    case get_field(changeset, :cycle) do
      nil -> changeset
      cycle ->
        case get_change(changeset, :first_bill_date) do
          nil -> changeset
          first_bill_date ->
            case cycle do
              "monthly" ->
                next_bill_date = calculate_next_bill_date(first_bill_date, :months)
                put_change(changeset, :next_bill_date, next_bill_date)
              "yearly" ->
                next_bill_date = calculate_next_bill_date(first_bill_date, :years)
                put_change(changeset, :next_bill_date, next_bill_date)
              _ ->
                changeset
            end
        end
    end
  end

  defp currency_symbol("EUR"), do: "€"
  defp currency_symbol("GBP"), do: "£"
  defp currency_symbol("USD"), do: "$"
  defp currency_symbol(_), do: nil

  # TODO: Move to helper module
  defp calculate_next_bill_date(from_date, step, until_date \\ today_beginning_of_day()) do
    if NaiveDateTime.diff(from_date, until_date) > 0 do
      from_date
    else
      from_date
      |> do_step(step)
      |> calculate_next_bill_date(step, until_date)
    end
  end

  defp do_step(from_date, :months), do: Timex.shift(from_date, months: 1)
  defp do_step(from_date, :years), do: Timex.shift(from_date, years: 1)

  defp today_beginning_of_day() do
    Timex.beginning_of_day(NaiveDateTime.utc_now())
  end

  # Consolidates amount as integer value before storing on the database.
  # 1.99 (£) will be saved as 199
  # 7 (£) will be saved as 700
  defp consolidate_amount(params = %{"amount" => amount}) when is_binary(amount) do
    case Float.parse(amount) do
      :error -> params # skip consolidate, fails on changeset
      {parsed, _} -> do_consolidate_amount(%{params | "amount" => parsed})
    end
  end
  defp consolidate_amount(params = %{"amount" => _amount}) do
    do_consolidate_amount(params)
  end
  defp consolidate_amount(params), do: params

  defp do_consolidate_amount(params = %{"amount" => amount}) do
    %{params | "amount" => Money.consolidate(amount)}
  end
end
