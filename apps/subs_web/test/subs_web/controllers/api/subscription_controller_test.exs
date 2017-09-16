defmodule SubsWeb.Test.Controllers.SubscriptionControllerTest do
  use SubsWeb.ConnCase
  import Subs.Test.Support.Factory
  alias SubsWeb.Test.Support.ApiHelpers

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "Authentication" do
    test "returns 401 for missing Authorization header", %{conn: conn} do
      conn = post(conn, api_subscription_path(conn, :create))

      assert data = json_response(conn, 401)
      assert data["message"] == "Unauthorized"
    end

    test "returns 401 for invalid Authorization token", %{conn: conn} do
      conn = put_req_header(conn, "authorization", "Bearer auth_token")
      conn = post(conn, api_subscription_path(conn, :create), subscription: %{})

      assert data = json_response(conn, 401)
      assert data["message"] == "Unauthorized"
    end

    test "returns 401 for invalid Authorization Bearer token", %{conn: conn} do
      conn = put_req_header(conn, "authorization", "random_token")
      conn = post(conn, api_subscription_path(conn, :create), subscription: %{})

      assert data = json_response(conn, 401)
      assert data["message"] == "Unauthorized"
    end

    test "returns 401 for valid token with unknown resource", %{conn: conn} do
      conn = ApiHelpers.put_authorization_header(conn, %{id: -1})
      conn = post(conn, api_subscription_path(conn, :create), subscription: %{})

      assert data = json_response(conn, 401)
      assert data["message"] == "Unauthorized"
    end

    test "returns 401 for valid token with unknown resource id", %{conn: conn} do
      conn = ApiHelpers.put_authorization_header(conn, %{id: "token"})
      conn = post(conn, api_subscription_path(conn, :create), subscription: %{})

      assert data = json_response(conn, 401)
      assert data["message"] == "Unauthorized"
    end
  end

  describe "GET /api/subscriptions" do
    setup %{conn: conn} do
      user = insert(:user)
      conn = ApiHelpers.put_authorization_header(conn, user)

      [conn: conn, user: user]
    end

    test "returns no subscriptions for user", %{conn: conn} do
      insert_list(3, :complete_subscription, %{user_id: insert(:user).id})
      conn = get(conn, api_subscription_path(conn, :index))

      assert %{"data" => subscriptions} = json_response(conn, 200)
      assert subscriptions == []
    end

    test "returns user subscriptions", %{conn: conn, user: user} do
      user_subscriptions = insert_list(3, :complete_subscription, %{user_id: user.id})
      conn = get(conn, api_subscription_path(conn, :index))

      assert %{"data" => subscriptions} = json_response(conn, 200)
      assert Enum.count(subscriptions) == 3

      for subscription <- user_subscriptions do
        assert Enum.find(subscriptions, fn(sub) -> sub["id"] == subscription.id end) != nil
      end
    end
  end

  describe "POST /api/subscriptions" do
    setup %{conn: conn} do
      user = insert(:user)
      conn = ApiHelpers.put_authorization_header(conn, user)

      [conn: conn]
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
