defmodule SubsWeb.Test.Controllers.ServiceControllerTest do
  use SubsWeb.ConnCase
  import Subs.Test.Support.Factory
  alias SubsWeb.Test.Support.ApiHelpers

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET /api/services" do
    setup %{conn: conn} do
      conn = ApiHelpers.put_authorization_header(conn, insert(:user))

      [conn: conn]
    end

    test "returns list of available services", %{conn: conn} do
      conn = get(conn, api_service_path(conn, :index))

      assert %{"data" => services} = json_response(conn, 200)
      assert Enum.count(services) > 0
    end

    test "returns Github as available service with color data", %{conn: conn} do
      conn = get(conn, api_service_path(conn, :index))

      assert %{"data" => services} = json_response(conn, 200)

      github_data = Enum.find(services, &(&1["code"] == "github"))

      assert github_data == %{
        "code" => "github",
        "name" => "Github",
        "color" => "#000000"
      }
    end
  end
end
