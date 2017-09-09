defmodule SubsWeb.Api.UserController do
  use SubsWeb, :controller
  alias Subs.UseCases.Users.AuthenticateUser
  alias SubsWeb.Api.ErrorView

  def authenticate(conn, %{"email" => email, "password" => password}) do
    case AuthenticateUser.perform(email, password) do
      {:ok, %{user: user, auth_token: auth_token}} ->
        conn
        |> put_status(:ok)
        |> render("authenticate.json", user: user, auth_token: auth_token)
      {:error, {:invalid_credentials, _}} ->
        conn
        |> put_status(:forbidden)
        |> render(ErrorView, :"403", message: "Invalid credentials")
    end
  end
  def authenticate(conn, _) do
    conn
    |> put_status(:bad_request)
    |> render(ErrorView, :"400", message: "Missing email and password")
  end
end
