defmodule SubsWeb.Test.Acceptance.UserSignupTest do
  use SubsWeb.FeatureCase, async: true

  import Wallaby.Query

  @tag :acceptance
  test "app loads", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("#app"))
    |> click(css("a[href=\"/signup\"]"))
    |> fill_in(css("#user-email"), with: "joaquim@example.com")
    |> fill_in(css("#user-password"), with: "123456")
    |> fill_in(css("#user-password-confirmation"), with: "123456")
    |> click(css("#signup-btn"))
    # TODO: finish
  end
end
