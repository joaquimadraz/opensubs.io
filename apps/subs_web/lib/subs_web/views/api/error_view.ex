defmodule SubsWeb.Api.ErrorView do
  use SubsWeb, :view

  def render("400.json", assigns) do
    %{message: assigns[:message] || "Bad request"}
  end
  def render("403.json", assigns) do
    %{message: assigns[:message] || "Forbidden"}
  end
  def render("404.json", assigns) do
    %{message: assigns[:message] || "Page not found"}
  end
  def render("409.json", assigns) do
    %{message: assigns[:message] || "Conflict"}
  end
  def render("500.json", assigns) do
    %{message: assigns[:message] || "Internal server error"}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end
end
