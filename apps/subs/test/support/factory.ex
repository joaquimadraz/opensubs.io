defmodule Subs.Test.Support.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Subs.Repo

  alias Subs.{User}

  def user_factory do
    %User{
      name: "Jon Snow",
      email: "jon.snow@email.com",
      password: "password",
      password_confirmation: "password",
      confirmation_token: "111xxx222yyy333zzz"
    }
  end
end
