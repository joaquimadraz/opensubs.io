defmodule Subs.SubscriptionRepo do
  @moduledoc false

  alias Subs.{Repo, Subscription}

  def create(params) do
    %Subscription{}
    |> Subscription.create_changeset(params)
    |> Repo.insert()
  end

  def create_with_user(user, params) do
    Subscription.build_with_user(user, params)
    |> Repo.insert()
  end
end
