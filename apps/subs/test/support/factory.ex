defmodule Subs.Test.Support.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Subs.Repo

  alias Subs.{User, Subscription}

  def user_factory do
    %User{
      name: "Jon Snow",
      email: "jon.snow@email.com",
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
end
