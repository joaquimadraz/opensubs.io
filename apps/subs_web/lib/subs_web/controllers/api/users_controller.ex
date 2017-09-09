defmodule SubsWeb.Api.UserController do
  use SubsWeb, :controller
  alias Subs.UseCases.Users.{AuthenticateUser, CreateUser}
  alias SubsWeb.Api.{ErrorView, ChangesetView}

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

  def create(conn, %{"user" => user_params}) do
    case CreateUser.perform(user_params) do
      {:ok, %{user: user}} ->
        conn
        |> put_status(:created)
        |> render("create.json", user: user)
      {:error, {:invalid_params, %{changeset: changeset}}} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ChangesetView, "error.json", changeset: changeset)
    end
  end
  def create(conn, _) do
    conn
    |> put_status(:bad_request)
    |> render(ErrorView, :"400", message: "Missing user params")
  end
end
