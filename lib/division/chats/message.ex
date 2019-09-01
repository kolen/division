defmodule Division.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Division.Accounts.User
  alias Division.Chats.Chat

  schema "messages" do
    field :content, :string
    belongs_to :chat, Chat
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(message, params) do
    message
    |> cast(params, [:chat_id, :content, :user_id])
    |> validate_required([:chat_id, :content, :user_id])
  end
end
