defmodule SubsServicesTest do
  use ExUnit.Case
  alias SubsServices.Store

  test "loads services from json file" do
    data = Store.get_service("github")

    assert data == %{
      "code" => "github",
      "name" => "Github",
      "color" => "#000000"
    }
  end
end
