defmodule SubsWeb.Api.SubscriptionController do
  use SubsWeb, :controller
  alias Subs.UseCases.Subscriptions.{
    CreateSubscription,
    FindUserSubscription,
    FindUserSubscriptions
  }
  alias SubsWeb.Helpers.UserHelper
  alias SubsWeb.Api.{ErrorView, ChangesetView}

  def index(conn, _params) do
    current_user = UserHelper.current_user(conn)

    case FindUserSubscriptions.perform(current_user) do
      {:ok, %{subscriptions: subscriptions}} ->
        conn
        |> put_status(:ok)
        |> render("index.json", subscriptions: subscriptions)
    end
  end

  def show(conn, %{"id" => subscription_id}) do
    current_user = UserHelper.current_user(conn)

    case FindUserSubscription.perform(current_user, subscription_id) do
      {:ok, %{subscription: subscription}} ->
        conn
        |> put_status(:ok)
        |> render("show.json", subscription: subscription)
      {:error, {:not_found, _}} ->
        conn
        |> put_status(:not_found)
        |> render(ErrorView, :"404", message: "Not found")
    end
  end
  def show(conn, _) do
    conn
    |> put_status(:bad_request)
    |> render(ErrorView, :"400", message: "Missing subscription id")
  end

  def create(conn, %{"subscription" => subscription_params}) do
    current_user = UserHelper.current_user(conn)

    case CreateSubscription.perform(current_user, subscription_params) do
      {:ok, %{subscription: subscription}} ->
        conn
        |> put_status(:created)
        |> render("create.json", subscription: subscription)
      {:error, {:invalid_params, %{changeset: changeset}}} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ChangesetView, "error.json", changeset: changeset)
    end
  end
  def create(conn, _) do
    conn
    |> put_status(:bad_request)
    |> render(ErrorView, :"400", message: "Missing subscription params")
  end
end
