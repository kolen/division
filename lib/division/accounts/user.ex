defmodule Division.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :password_hash, :string
    field :username, :string

    # Virtual fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash])
    |> validate_required([:username, :password_hash])
    |> unique_constraint(:username)
  end
end
