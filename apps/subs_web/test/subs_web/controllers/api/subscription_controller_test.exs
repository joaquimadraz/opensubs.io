defmodule SubsWeb.Test.Controllers.SubscriptionControllerTest do
  use SubsWeb.ConnCase
  import Subs.Test.Support.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "POST /api/subscriptions" do
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
        "amount" => ["must be greater than 0"],
        "amount_currency" => ["unknown currency"],
        "cycle" => ["must be one of: monthly, yearly"],
        "color" => ["invalid format, must be HEX format, ex: #FF0000"],
        "first_bill_date" => ["invalid date"]
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
        "first_bill_date" => "2017-09-12"
      })

      assert data = json_response(conn, 202)
      assert data["data"] == %{
        "name" => "Custom Service",
        "description" => "Custom Service Subscription",
        "amount" => "7.99",
        "amount_currency" => "GBP",
        "amount_currency_symbol" => "£",
        "cycle" => "monthly",
        "color" => "#36dd30",
        "first_bill_date" => "2017-09-12",
        "next_bill_date" => "2017-10-12"
      }
    end

    test "creates a subscription from a service", %{conn: conn} do
      conn = post(conn, api_subscription_path(conn, :create), subscription: %{
        "description" => "Some Subscription",
        "amount" => "7.99",
        "amount_currency" => "GBP",
        "cycle" => "monthly",
        "first_bill_date" => "2017-09-12",
        "service_id" => 1,
      })

      assert data = json_response(conn, 202)
      assert data["data"] == %{
        "name" => "Spotify",
        "description" => "Some Subscription",
        "amount" => "7.99",
        "amount_currency" => "GBP",
        "amount_currency_symbol" => "£",
        "cycle" => "monthly",
        "color" => "#36dd30",
        "first_bill_date" => "2017-09-12",
        "next_bill_date" => "2017-10-12",
        "service_id" => 1
      }
    end
  end
end
