defmodule Subs.Test.Support.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Subs.Repo

  alias Subs.{User, Subscription}

  def user_factory do
    %User{
      name: "Jon Snow",
      email: sequence(:email, &"jon.snow.#{&1}@email.com"),
      password: "password",
      password_confirmation: "password",
      confirmation_token: "111xxx222yyy333zzz"
    }
  end

  def subscription_factory do
    %Subscription{
      name: "Custom Service",
      amount: 7,
      amount_currency: "GBP",
      cycle: "monthly"
    }
  end

  def complete_subscription_factory do
    %Subscription{
      name: "Custom Service",
      amount: 700,
      amount_currency: "GBP",
      amount_currency_symbol: "£",
      cycle: "monthly",
      first_bill_date: NaiveDateTime.utc_now(),
      next_bill_date: NaiveDateTime.utc_now()
    }
  end
end
