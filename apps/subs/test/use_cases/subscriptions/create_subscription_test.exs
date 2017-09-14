defmodule Subs.Test.UseCases.Subscriptions.CreateSubscriptionTest do
  use Subs.DataCase
  import Subs.Test.Support.Factory

  alias Subs.UseCases.Subscriptions.CreateSubscription

  test "returns error for missing params" do
    assert{:error, :missing_params} = CreateSubscription.perform(%{})
  end
end
