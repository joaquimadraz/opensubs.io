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

  @tag :acceptance
  test "visit login page, clicks recover password and back to login", %{session: session} do
    session
    |> visit("/login")
    |> assert_has(button("Recover password"))
    |> click(button("Recover password"))

    assert has_no_css?(session, "#login-form")

    session
    |> assert_has(css("#recover-password-form"))
    |> click(button("Back"))
    |> assert_has(css("#login-form"))

    assert has_no_css?(session, "#recover-password-form")
  end

  @tag :acceptance
  test "visits recover password form and get error for invalid email", %{session: session} do
    session
    |> visit("/login")
    |> assert_has(button("Recover password"))
    |> click(button("Recover password"))
    |> fill_in(css("#recover-password-form .user-email"), with: "invalid")
    |> click(css("#recover-password-btn"))
    |> assert_has(css("li", text: "email: has invalid format"))
  end

  @tag :acceptance
  test "visits recover password form and recovers with success", %{session: session} do
    email = "jonjones@example.com"

    session
    |> visit("/login")
    |> assert_has(button("Recover password"))
    |> click(button("Recover password"))
    |> fill_in(css("#recover-password-form .user-email"), with: email)
    |> click(css("#recover-password-btn"))
    |> assert_has(css("p", text: "A recover password email is on the way"))
  end
end
