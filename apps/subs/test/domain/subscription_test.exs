defmodule Subs.Test.Domain.SubscriptionTest do
  use ExUnit.Case
  import Subs.Test.Support.Factory
  alias Subs.Subscription
  alias Ecto.Changeset

  def create_changeset(params) do
    Subscription.create_changeset(%Subscription{}, params)
  end

  describe("color") do
    test "returns error for invalid color format" do
      params = string_params_for(:subscription, color: "invalid")
      changeset = create_changeset(params)

      assert {"invalid format, must be HEX format, ex: #FF0000", _} = changeset.errors[:color]
    end

    test "upcases color value" do
      params = string_params_for(:subscription, color: "#Ff00aB")
      changeset = create_changeset(params)
      color = Changeset.get_change(changeset, :color)

      assert color == "#FF00AB"
    end
  end

  describe("amount, amount_currency and amount_currency_symbol") do
    test "returns error for invalid currency" do
      params = string_params_for(
        :subscription,
        amount: 799,
        amount_currency: "WHAT",
      )
      changeset = create_changeset(params)

      assert {"unknown currency", _} = changeset.errors[:amount_currency]
    end

    test "populates amount_currency_symbol" do
      params = string_params_for(
        :subscription,
        amount: 799,
        amount_currency: "GBP",
      )
      changeset = create_changeset(params)
      symbol = Changeset.get_change(changeset, :amount_currency_symbol)

      assert symbol == "£"
    end
  end

  describe("first_bill_date and next_bill_date") do
    test "populates first_bill_date if not given" do
      params = string_params_for(:subscription)
      changeset = create_changeset(params)
      first_bill_date = Changeset.get_change(changeset, :first_bill_date)

      assert NaiveDateTime.to_date(first_bill_date) == Date.utc_today()
    end

    test "populates next_bill_date based on monthly cycle" do
      params = string_params_for(
        :subscription,
        first_bill_date: "2017-09-12T00:00:00Z"
      )
      changeset = create_changeset(params)
      next_bill_date = Changeset.get_change(changeset, :next_bill_date)

      assert next_bill_date == ~N[2017-10-12 00:00:00]
    end

    test "populates next_bill_date based on yearly cycle" do
      params = string_params_for(
        :subscription,
        cycle: "yearly",
        first_bill_date: "2017-09-12T00:00:00Z"
      )
      changeset = create_changeset(params)
      next_bill_date = Changeset.get_change(changeset, :next_bill_date)

      assert next_bill_date == ~N[2018-09-12 00:00:00]
    end
  end
end
