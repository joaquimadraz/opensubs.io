defmodule SubsServicesTest do
  use ExUnit.Case

  test "loads services from json file" do
    data = SubsServices.get_service("github")

    assert data == %{
      "code" => "github",
      "name" => "Github",
      "color" => "#000000"
    }
  end
end
