defmodule Division.Chats do
  @moduledoc """
  The Chats context.
  """

  import Ecto.Query, warn: false
  alias Division.Repo
  alias Division.Chats.Chat
  alias Division.Chats.Message
  alias Division.Chats.Access
  alias Division.Accounts.User

  @doc """
  Returns the list of messages.

  ## Examples

      iex> list_messages()
      [%Message{}, ...]

  """
  def list_messages do
    Repo.all(Message)
  end

  @doc """
  Gets a single message.

  Raises `Ecto.NoResultsError` if the Message does not exist.

  ## Examples

      iex> get_message!(123)
      %Message{}

      iex> get_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_message!(id), do: Repo.get!(Message, id)

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Message.

  ## Examples

      iex> delete_message(message)
      {:ok, %Message{}}

      iex> delete_message(message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Ecto.Changeset{source: %Message{}}

  """
  # TODO: check arguments syntax
  def change_message(%Message{} = message \\ %Message{}) do
    Message.changeset(message, %{})
  end

  def change_message(changeset, changes) do
    Message.changeset(changeset, changes)
  end

  @doc """
  Returns the list of chats.

  ## Examples

      iex> list_chats()
      [%Chat{}, ...]

  """
  def list_chats do
    query =
      from chat in Chat,
        where: chat.private == false

    Repo.all(query)
  end

  @doc """
  Gets a single chat.

  Raises `Ecto.NoResultsError` if the Chat does not exist.

  ## Examples

      iex> get_chat!(123)
      %Chat{}

      iex> get_chat!(456)
      ** (Ecto.NoResultsError)

  """
  def get_chat!(id), do: Repo.get!(Chat, id)

  def get_chat_with_messages(chat_id) do
    msg_query =
      from msg in Message,
        limit: 2048,
        order_by: [desc: msg.inserted_at],
        preload: [:user]

    query =
      from c in Chat,
        where: c.id == ^chat_id,
        preload: [messages: ^msg_query]

    Repo.one(query)
  end

  def chat_name_for(%User{:id => id_a}, %User{:id => id_b}) do
    [left, right] = Enum.sort([id_a, id_b])
    "#{left}.#{right}"
  end

  def get_dialog(%User{} = user_a, %User{} = user_b) do
    chat_query =
      from chat in Chat,
        where: chat.name == ^chat_name_for(user_a, user_b)

    Repo.one(chat_query)
  end

  def chat_type(%Chat{:name => name}) do
    case String.split(name, ".") do
      [_] -> :chat
      [_, _] -> :dialog
    end
  end

  @doc """
  Creates a chat.

  ## Examples

      iex> create_chat(%{field: value})
      {:ok, %Chat{}}

      iex> create_chat(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_chat(attrs \\ %{}) do
    %Chat{}
    |> Chat.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a chat.

  ## Examples

      iex> update_chat(chat, %{field: new_value})
      {:ok, %Chat{}}

      iex> update_chat(chat, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_chat(%Chat{} = chat, attrs) do
    chat
    |> Chat.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Chat.

  ## Examples

      iex> delete_chat(chat)
      {:ok, %Chat{}}

      iex> delete_chat(chat)
      {:error, %Ecto.Changeset{}}

  """
  def delete_chat(%Chat{} = chat) do
    Repo.delete(chat)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking chat changes.

  ## Examples

      iex> change_chat(chat)
      %Ecto.Changeset{source: %Chat{}}

  """
  def change_chat(%Chat{} = chat) do
    Chat.changeset(chat, %{})
  end

  @doc """
  ## Examples

      iex> create_access(%{field: value})
      {:ok, %Access{}}

      iex> create_access(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_access(attrs \\ %{}) do
    %Access{}
    |> Access.changeset(attrs)
    |> Repo.insert()
  end
end
