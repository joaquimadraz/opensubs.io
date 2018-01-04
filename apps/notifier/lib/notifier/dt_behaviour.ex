defmodule Notifier.DTBehaviour do
  @moduledoc false
  @callback now() :: NaiveDatetime.t
end
