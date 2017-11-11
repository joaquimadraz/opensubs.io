defmodule SubsWeb.Test.Acceptance.UserLoginTest do
  use SubsWeb.FeatureCase, async: true

  import Wallaby.Query

  @tag :acceptance
  test "render error message when login fails", %{session: session} do
    session
    |> visit("/login")
    |> assert_has(css("#login-form"))
    |> fill_in(css("#login-form .user-email"), with: "unexisting")
    |> fill_in(css("#login-form .user-password"), with: "nope")
    |> click(css("#login-btn"))
    |> assert_has(css("p", text: "Invalid credentials"))
  end
end
