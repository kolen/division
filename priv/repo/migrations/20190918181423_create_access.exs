defmodule Division.Repo.Migrations.CreateAccess do
  use Ecto.Migration

  def change do
    create table(:access) do
      add :user_id, references(:users, on_delete: :nothing)
      add :chat_id, references(:chats, on_delete: :nothing)

      timestamps()
    end

    create index(:access, [:user_id])
    create index(:access, [:chat_id])
  end
end
