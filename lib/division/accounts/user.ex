defmodule Division.Accounts.User do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  alias Division.Accounts.Encryption
  alias Division.Chats.Chat

  schema "users" do
    field :password_hash, :string
    field :username, :string
    field :avatar, Division.Avatar.Type
    # Durov, put back the wall!
    belongs_to :chat, Chat

    # Virtual fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, params) do
    user
    |> cast(params, [:username, :password, :chat_id])
    |> cast_attachments(params, [:avatar])
    |> validate_required([:username])
    |> unique_constraint(:username)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> validate_format(:username, ~r/^[a-z0-9][a-z0-9]+[a-z0-9]$/i)
    |> validate_length(:username, min: 3)
    |> downcase_username
    |> hash_password
  end

  defp downcase_username(changeset) do
    update_change(changeset, :username, &String.downcase/1)
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)

    if password do
      password_hash = Encryption.hash_password(password)
      put_change(changeset, :password_hash, password_hash)
    else
      changeset
    end
  end
end
