defmodule Subs.Repo.Migrations.AddPasswordRecoveryFields do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :password_recovery_token, :string
      add :password_recovery_expires_at, :naive_datetime
      add :password_recovery_used_at, :naive_datetime
    end

    create index("users", [:password_recovery_token])
    create index("users", [:password_recovery_expires_at])
  end
end
