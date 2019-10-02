defmodule Division.Chats.Access do
  use Ecto.Schema
  import Ecto.Changeset
  alias Division.Accounts.User
  alias Division.Chats.Chat

  schema "access" do
    belongs_to :user, User
    belongs_to :chat, Chat

    timestamps()
  end

  @doc false
  def changeset(access, params) do
    access
    |> cast(params, [:chat_id, :user_id])
    |> validate_required([])
  end
end
