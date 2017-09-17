defmodule SubsServicesTest do
  use ExUnit.Case
  doctest SubsServices

  test "greets the world" do
    assert SubsServices.hello() == :world
  end
end
