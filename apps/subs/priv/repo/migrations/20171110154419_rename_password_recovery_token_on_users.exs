defmodule Subs.Repo.Migrations.RenamePasswordRecoveryTokenOnUsers do
  use Ecto.Migration

  def change do
    drop index("users", [:password_recovery_token])
    rename table("users"), :password_recovery_token, to: :encrypted_password_recovery_token
    create index("users", [:encrypted_password_recovery_token])
  end
end
