defmodule Division.Repo.Migrations.AddPrivateBooleanToChat do
  use Ecto.Migration

  def change do
    alter table(:chats) do
      add :private, :boolean, default: true
    end

    create index(:chats, [:private])
  end
end
