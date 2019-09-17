defmodule Division.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset
  alias Division.Chats.Message
  alias Division.Accounts.User

  schema "chats" do
    field :name, :string
    field :private, :boolean
    has_many :messages, Message, on_delete: :delete_all
    has_many :users, User

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 3)
  end
end
