defmodule Subs.Repo.Migrations.RenameConfirmationTokenOnUsers do
  use Ecto.Migration

  def change do
    rename table("users"), :confirmation_token, to: :encrypted_confirmation_token
    create index("users", [:encrypted_confirmation_token])
  end
end
