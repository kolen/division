defmodule Division.Chats.Access do
  use Ecto.Schema
  import Ecto.Changeset

  schema "access" do
    field :user_id, :id
    field :chat_id, :id

    timestamps()
  end

  @doc false
  def changeset(access, attrs) do
    access
    |> cast(attrs, [])
    |> validate_required([])
  end
end
