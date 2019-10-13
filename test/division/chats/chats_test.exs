defmodule Division.ChatsTest do
  use Division.DataCase

  alias Division.Chats
  alias Division.Accounts.User

  describe "chats" do
    alias Division.Chats.Chat

    @valid_attrs %{name: "some name", private: true}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def chat_fixture(attrs \\ %{}) do
      {:ok, chat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chats.create_chat()

      chat
    end

    def dialog_fixture(attrs \\ %{}) do
      {:ok, chat} =
        attrs
        |> Enum.into(%{name: "14.88", private: true})
        |> Chats.create_chat()

      chat
    end

    test "list_chats/0 returns all chats" do
      chat = chat_fixture(private: false)
      assert Chats.list_chats() == [chat]
    end

    test "get_chat!/1 returns the chat with given id" do
      chat = chat_fixture()
      assert Chats.get_chat!(chat.id) == chat
    end

    test "get_dialog/2 returns the dialog for two users" do
      chat = dialog_fixture()
      assert Chats.get_dialog(%User{id: 88}, %User{id: 14}) == chat
    end

    test "create_chat/1 with valid data creates a chat" do
      assert {:ok, %Chat{} = chat} = Chats.create_chat(@valid_attrs)
      assert chat.name == "some name"
    end

    test "create_chat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_chat(@invalid_attrs)
    end

    test "chat_type/1 for regular chat" do
      assert :chat = Chats.chat_type(%Chat{name: "lepr"})
    end

    test "chat_type/1 for dialog" do
      assert :dialog = Chats.chat_type(%Chat{name: "123.456"})
    end

    test "update_chat/2 with valid data updates the chat" do
      chat = chat_fixture()
      assert {:ok, %Chat{} = chat} = Chats.update_chat(chat, @update_attrs)
      assert chat.name == "some updated name"
    end

    test "update_chat/2 with invalid data returns error changeset" do
      chat = chat_fixture()
      assert {:error, %Ecto.Changeset{}} = Chats.update_chat(chat, @invalid_attrs)
      assert chat == Chats.get_chat!(chat.id)
    end

    test "delete_chat/1 deletes the chat" do
      chat = chat_fixture()
      assert {:ok, %Chat{}} = Chats.delete_chat(chat)
      assert_raise Ecto.NoResultsError, fn -> Chats.get_chat!(chat.id) end
    end

    test "change_chat/1 returns a chat changeset" do
      chat = chat_fixture()
      assert %Ecto.Changeset{} = Chats.change_chat(chat)
    end

    test "check_access/2 returns :error tuple with nil if access is not exists" do
      assert {:error, nil} = Chats.check_access(%Chat{id: 14}, %User{id: 88})
    end
  end
end
