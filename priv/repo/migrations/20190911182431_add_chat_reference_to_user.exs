defmodule Division.Repo.Migrations.AddChatReferenceToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :chat_id, references(:chats, on_delete: :nothing)
    end

    create index(:users, [:chat_id])
  end
end
