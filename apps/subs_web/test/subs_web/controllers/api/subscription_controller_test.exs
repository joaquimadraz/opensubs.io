defmodule SubsWeb.Test.Controllers.SubscriptionControllerTest do
  use SubsWeb.ConnCase
  import Subs.Test.Support.Factory
  alias SubsWeb.Helpers.UserHelper

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "returns 401 for missing Authorization header", %{conn: conn} do
    conn = post(conn, api_subscription_path(conn, :create))

    assert data = json_response(conn, 401)
    assert data["message"] == "Unauthorized"
  end

  test "returns 401 for invalid token", %{conn: conn} do
    conn =
      conn
      |> put_req_header("authorization", "Bearer token")
      |> post(api_subscription_path(conn, :index))

    assert data = json_response(conn, 401)
    assert data["message"] == "Unauthorized"
  end

  test "returns 403 for valid token with invalid resource", %{conn: conn} do
    auth_token = UserHelper.generate_auth_token(%{id: -1})
    conn =
      conn
      |> put_req_header("authorization", "Bearer #{auth_token}")
      |> post(api_subscription_path(conn, :create), subscription: %{})

    assert data = json_response(conn, 401)
    assert data["message"] == "Unauthorized"
  end

  describe "POST /api/subscriptions" do
    setup %{conn: conn} do
      user = insert(:user)
      auth_token = UserHelper.generate_auth_token(user)
      conn = put_req_header(conn, "authorization", "Bearer #{auth_token}")

      [conn: conn, user: user]
    end

    test "returns bad request when requesting without subscription params", %{conn: conn} do
      conn = post(conn, api_subscription_path(conn, :create))

      assert data = json_response(conn, 400)
      assert data["message"] == "Missing subscription params"
    end

    test "returns unprocessable entity when requesting with empty subscription params",
         %{conn: conn} do
      conn = post(conn, api_subscription_path(conn, :create), subscription: %{})

      assert data = json_response(conn, 422)
      assert data["data"]["errors"] == %{
        "name" => ["can't be blank"],
        "amount" => ["can't be blank"],
        "amount_currency" => ["can't be blank"],
        "cycle" => ["can't be blank"],
      }
    end

    test  "returns unprocessable entity when given invalid params", %{conn: conn} do
      conn = post(conn, api_subscription_path(conn, :create), subscription: %{
        "amount" => -1,
        "amount_currency" => "DUNNO",
        "cycle" => "hourly",
        "color" => "invalid",
        "first_bill_date" => "invalid"
      })

      assert data = json_response(conn, 422)
      assert data["data"]["errors"] == %{
        "name" => ["can't be blank"],
        "amount" => ["must be greater than 0"],
        "amount_currency" => ["unknown currency"],
        "cycle" => ["must be one of: monthly, yearly"],
        "color" => ["invalid format, must be HEX format, ex: #FF0000"],
        "first_bill_date" => ["is invalid"]
      }
    end

    test "creates custom subscription given all params", %{conn: conn} do
      conn = post(conn, api_subscription_path(conn, :create), subscription: %{
        "name" => "Custom Service",
        "description" => "Custom Service Subscription",
        "amount" => "7.99",
        "amount_currency" => "GBP",
        "cycle" => "monthly",
        "color" => "#36dd30",
        "first_bill_date" => "2017-09-12T00:00:00Z"
      })

      assert data = json_response(conn, 201)

      {id, data} = Map.pop(data["data"], "id")

      assert id != nil
      assert data == %{
        "name" => "Custom Service",
        "description" => "Custom Service Subscription",
        "amount" => 7.99,
        "amount_currency" => "GBP",
        "amount_currency_symbol" => "£",
        "cycle" => "monthly",
        "color" => "#36DD30",
        "first_bill_date" => "2017-09-12T00:00:00Z",
        "next_bill_date" => "2017-10-12T00:00:00Z"
      }
    end
  end
end
