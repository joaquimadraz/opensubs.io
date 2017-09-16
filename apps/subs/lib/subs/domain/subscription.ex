defmodule Subs.Subscription do
  @moduledoc false

  use Subs.Schema
  alias Subs.User

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

  @currency_codes ~w(EUR GBP USD)
  @cycles ~w(monthly yearly)
  @default_color "#E2E2E2"

  def build_with_user(user, params) do
    user
    |> build_assoc(:subscriptions)
    |> create_changeset(params)
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_create_fields ++ @optional_fields)
    |> validate_required(@required_create_fields)
    |> foreign_key_constraint(:user_id)
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
        put_change(changeset, :first_bill_date, Timex.to_naive_datetime(Timex.today()))
        _ ->
        changeset
    end
  end

  defp populate_next_bill_date(changeset = %{valid?: false}), do: changeset
  defp populate_next_bill_date(changeset) do
    case get_change(changeset, :cycle) do
      nil -> changeset
      cycle ->
        case get_change(changeset, :first_bill_date) do
          nil -> changeset
          date ->
            case cycle do
              "monthly" ->
                next_bill_date = Timex.shift(date, months: 1)
                put_change(changeset, :next_bill_date, Timex.to_naive_datetime(next_bill_date))
              "yearly" ->
                next_bill_date = Timex.shift(date, years: 1)
                put_change(changeset, :next_bill_date, Timex.to_naive_datetime(next_bill_date))
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
end
