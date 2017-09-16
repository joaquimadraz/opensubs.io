defmodule SubsWeb.Api.SubscriptionController do
  use SubsWeb, :controller
  alias Subs.UseCases.Subscriptions.CreateSubcription

  def create(conn, params) do
    conn
    |> put_status(:ok)
    |> text("hey")
  end
end
