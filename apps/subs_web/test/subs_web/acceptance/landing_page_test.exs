defmodule SubsWeb.Test.Acceptance.LandingPageTest do
  use SubsWeb.FeatureCase

  import Wallaby.Query, only: [css: 1]

  @tag :acceptance
  test "app loads", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("#app"))
  end
end
