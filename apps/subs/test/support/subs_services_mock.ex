defmodule Subs.Test.Support.SubsServicesMock do
  @moduledoc false

  def github_data do
    %{
      "code" => "github",
      "name" => "Github",
      "color" => "#000000"
    }
  end

  def get_services, do: [github_data()]

  def get_service("github"), do: github_data()
  def get_service(_), do: nil
end
