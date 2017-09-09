defmodule Subs.UserRepo do
  @moduledoc false

  alias Subs.{Repo, User}

  def create(params) do
    %User{}
    |> User.create_changeset(params)
    |> Repo.insert
  end

  def update(user, params) do
    user
    |> User.update_changeset(params)
    |> Repo.update()
  end

  def delete(user) do
    Repo.delete(user)
  end

  def get_by_email(email) do
    Repo.get_by(User, email: String.downcase(email))
  end

  def get_by_id(user_id), do: Repo.get(User, user_id)
end