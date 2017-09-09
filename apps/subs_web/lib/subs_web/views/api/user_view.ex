defmodule SubsWeb.Api.UserView do
  use SubsWeb, :view
  alias SubsWeb.Api.UserView

  def render("authenticate.json", %{user: user, auth_token: auth_token}) do
    %{
      data: render_one(user, UserView, "user.json"),
      meta: %{
        auth_token: auth_token
      }
    }
  end

  def render("create.json", %{user: user}) do
    render("show.json", %{user: user})
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email
    }
  end
end
