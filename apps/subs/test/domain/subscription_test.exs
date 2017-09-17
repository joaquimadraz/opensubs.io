defmodule Subs.Test.Domain.SubscriptionTest do
  use Subs.DataCase
  import Subs.Test.Support.Factory
  alias Subs.Subscription
  alias Ecto.Changeset

  def create_changeset(params) do
    Subscription.create_changeset(%Subscription{}, params)
  end

  def build_changeset_with_user(user, params) do
    Subscription.build_with_user(user, params)
  end

  describe("user") do
    test "returns error for missing user" do
      non_persisted_user = build(:user)
      params = string_params_for(:subscription)
      changeset = build_changeset_with_user(non_persisted_user, params)

      assert {"can't be blank", _} = changeset.errors[:user_id]
    end

    test "creates subscription from user" do
      user = insert(:user)
      params = string_params_for(:subscription)
      changeset = build_changeset_with_user(user, params)

      assert changeset.valid? == true
    end
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
    setup do
      [user: insert(:user)]
    end

    test "populates first_bill_date if not given", %{user: user} do
      params = string_params_for(:subscription)
      changeset = build_changeset_with_user(user, params)
      first_bill_date = Changeset.get_change(changeset, :first_bill_date)

      assert NaiveDateTime.to_date(first_bill_date) == Date.utc_today()
    end

    test "populates next_bill_date based on monthly cycle", %{user: user} do
      params = string_params_for(
        :subscription,
        first_bill_date: "2017-09-12T00:00:00Z"
      )
      changeset = build_changeset_with_user(user, params)
      first_bill_date = Changeset.get_change(changeset, :first_bill_date)
      next_bill_date = Changeset.get_change(changeset, :next_bill_date)

      assert NaiveDateTime.diff(next_bill_date, first_bill_date) > 0
    end

    test "populates next_bill_date based on yearly cycle", %{user: user} do
      params = string_params_for(
        :subscription,
        cycle: "yearly",
        first_bill_date: "2017-09-12T00:00:00Z"
      )
      changeset = build_changeset_with_user(user, params)
      first_bill_date = Changeset.get_change(changeset, :first_bill_date)
      next_bill_date = Changeset.get_change(changeset, :next_bill_date)

      assert NaiveDateTime.diff(next_bill_date, first_bill_date) > 0
    end

    test "populates next_bill_date for next month if first_fill_date is from the past", %{user: user} do
      params = string_params_for(
        :subscription,
        cycle: "monthly",
        first_bill_date: "2017-01-01T00:00:00Z"
      )
      changeset = build_changeset_with_user(user, params)
      first_bill_date = Changeset.get_change(changeset, :first_bill_date)
      next_bill_date = Changeset.get_change(changeset, :next_bill_date)

      assert NaiveDateTime.diff(next_bill_date, first_bill_date) > 0
    end

    test "populates next_bill_date for next year if first_fill_date is from the past", %{user: user} do
      params = string_params_for(
        :subscription,
        cycle: "yearly",
        first_bill_date: "2016-01-01T00:00:00Z"
      )
      changeset = build_changeset_with_user(user, params)
      first_bill_date = Changeset.get_change(changeset, :first_bill_date)
      next_bill_date = Changeset.get_change(changeset, :next_bill_date)

      assert NaiveDateTime.diff(next_bill_date, first_bill_date) > 0
    end

    test "populates next_bill_date forwarding a bunch of months", %{user: user} do
      params = string_params_for(
        :subscription,
        cycle: "yearly",
        first_bill_date: "1900-01-01T00:00:00Z"
      )
      changeset = build_changeset_with_user(user, params)
      first_bill_date = Changeset.get_change(changeset, :first_bill_date)
      next_bill_date = Changeset.get_change(changeset, :next_bill_date)

      assert NaiveDateTime.diff(next_bill_date, first_bill_date) > 0
    end
  end
end
