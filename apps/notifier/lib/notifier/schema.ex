defmodule Notifier.Schema do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
    end
  end
end
