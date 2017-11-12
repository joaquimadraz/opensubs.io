defmodule SubsWeb.Test.Acceptance.UserLoginTest do
  use SubsWeb.FeatureCase, async: true

  import Wallaby.Query

  alias Subs.{User, UserRepo}

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

  @tag :acceptance
  test "login successful and redirects to root page with email rendered", %{session: session} do
    email = "joaquim@example.com"
    password = "123456"

    session
    |> visit("/signup")
    |> assert_has(css("#app"))
    |> fill_in(css("#signup-form .user-email"), with: email)
    |> fill_in(css("#signup-form .user-password"), with: password)
    |> fill_in(css("#signup-form .user-password-confirmation"), with: password)
    |> click(css("#signup-btn"))
    |> assert_has(css("p", text: "A confirmation email was sent to #{email}."))

    # Set known confirmation token
    user = UserRepo.get_by_email(email)
    {:ok, user} = User.confirmation_changeset(user) |> Repo.update()

    session
    |> visit("/users/confirm_signup?t=#{user.confirmation_token}")
    |> assert_has(css("#app"))
    |> assert_has(css("p", text: "Account confirmed, ready to login"))

    session
    |> visit("/login")
    |> assert_has(css("#login-form"))
    |> fill_in(css("#login-form .user-email"), with: email)
    |> fill_in(css("#login-form .user-password"), with: password)
    |> click(css("#login-btn"))
    |> assert_has(css(".current-user", text: email))
  end
end
