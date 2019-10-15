defmodule Division.Repo.Migrations.AddBioTextToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :bio, :text, default: ""
    end
  end
end
