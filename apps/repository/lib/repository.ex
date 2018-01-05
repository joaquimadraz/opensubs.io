defmodule Repository do
  @moduledoc """
  Now both Notifier and Subs use Repository.
  Before each app had it's own repository with it's own process and connections.
  I had to move it to extract the Ecto.Repo process into a separate app
  because it's not possible able to use Transactions between two different Repo.
  Check subs/apps/subs/lib/subs/domain/subs_notification_repo.ex .
  """
end
