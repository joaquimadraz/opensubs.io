defmodule Subs.UseCase do
  @moduledoc """
  Helper functions to build our use cases.

  Subs.UseCase.Flow

  Adds ok! and failure! functions to create a standard way of returning
  use case's context.
  """
  def base do
    quote do
      import Subs.UseCase.Flow
    end
  end

  defmacro __using__([]) do
    apply(__MODULE__, :base, [])
  end
end

defmodule Subs.UseCase.Flow do
  @moduledoc false

  def ok!(context \\ []) do
    {:ok, context}
  end

  def failure!(status, context \\ []) do
    {:error, {status, context}}
  end
end
