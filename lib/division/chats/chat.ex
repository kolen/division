defmodule Division.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset
  alias Division.Chats.Message

  schema "chats" do
    field :name, :string
    has_many :messages, Message, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
