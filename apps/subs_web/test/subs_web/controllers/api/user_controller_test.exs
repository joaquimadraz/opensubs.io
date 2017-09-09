defmodule SubsWeb.Test.Controllers.UserControllerTest do
  use SubsWeb.ConnCase
  import Subs.Test.Support.Factory
  alias Subs.Test.Support.BCrypt

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "POST /api/users/authenticate" do
    setup %{conn: conn} do
      user_password = "password"

      user = insert(:user, encrypted_password: BCrypt.hashpwsalt(user_password))

      [conn: conn,
       user: user,
       user_password: user_password]
    end

    test "returns forbidden for missing credentials", %{conn: conn} do
      conn = post(conn, api_user_authenticate_path(conn, :authenticate))

      assert data = json_response(conn, 400)
      assert data["message"] == "Missing email and password"
    end

    test "returns forbidden for invalid credentials", %{conn: conn} do
      conn = post(conn, api_user_authenticate_path(conn, :authenticate), %{
        email: "unknown@email.com",
        password: "password"
      })

      assert data = json_response(conn, 403)
      assert data["message"] == "Invalid credentials"
    end

    test "authenticates user and returns auth_token",
         %{conn: conn, user: user, user_password: user_password} do
      conn = post(conn, api_user_authenticate_path(conn, :authenticate), %{
        "email" => user.email,
        "password" => user_password
      })

      assert data = json_response(conn, 200)

      {:ok, claims} = Subs.Guardian.decode_and_verify(data["meta"]["auth_token"])

      assert claims["sub"] == Integer.to_string(user.id)
    end

    test "authenticates user and returns user data",
         %{conn: conn, user: user, user_password: user_password} do
      conn = post(conn, api_user_authenticate_path(conn, :authenticate), %{
        "email" => user.email,
        "password" => user_password
      })

      assert data = json_response(conn, 200)
      assert data["data"] == %{
        "id" => user.id,
        "name" => user.name,
        "email" => user.email
      }
    end
  end
end

