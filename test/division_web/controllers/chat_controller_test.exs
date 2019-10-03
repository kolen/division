defmodule DivisionWeb.ChatControllerTest do
  use DivisionWeb.ConnCase

  alias Division.Chats
  alias Division.Accounts

  @create_public_attrs %{name: "Leprosorium", private: false}
  @create_private_attrs %{name: "Secret Leprosorium", private: true}
  @update_attrs %{name: "Wolchat"}
  @invalid_attrs %{name: nil}
  @user %{username: "Grach", password: "yobaboba"}

  def fixture(:chat) do
    {:ok, chat} = Chats.create_chat(@create_public_attrs)
    chat
  end

  def fixture(:user) do
    {:ok, chat} = Accounts.create_user(@user)
    chat
  end

  describe "index" do
    setup [:create_user]

    test "lists all chats", %{conn: conn, user: user} do
      conn =
        conn
        |> session_conn()
        |> put_session(:current_user_id, user.id)
        |> get(Routes.chat_path(conn, :index))

      assert html_response(conn, 200) =~ "Listing Chats"
    end
  end

  describe "new chat" do
    setup [:create_user]

    test "renders form", %{conn: conn, user: user} do
      conn =
        conn
        |> session_conn()
        |> put_session(:current_user_id, user.id)
        |> get(Routes.chat_path(conn, :new))

      assert html_response(conn, 200) =~ "New Chat"
    end
  end

  describe "create public chat" do
    setup [:create_user]

    test "redirects to show when data is valid", %{conn: conn, user: user} do
      conn =
        conn
        |> session_conn()
        |> put_session(:current_user_id, user.id)
        |> post(Routes.chat_path(conn, :create), chat: @create_public_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.chat_path(conn, :show, id)

      conn = get(conn, Routes.chat_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Chat created successfully"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      response =
        conn
        |> session_conn()
        |> put_session(:current_user_id, user.id)
        |> post(Routes.chat_path(conn, :create), chat: @invalid_attrs)
        |> html_response(200)

      assert response =~ "New Chat"
    end
  end

  describe "create private chat" do
    setup [:create_user]

    test "redirects to show when data is valid", %{conn: conn, user: user} do
      conn =
        conn
        |> session_conn()
        |> put_session(:current_user_id, user.id)
        |> post(Routes.chat_path(conn, :create), chat: @create_private_attrs)

      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end
  end

  describe "edit chat" do
    setup [:create_user]
    setup [:create_chat]

    test "renders form for editing chosen chat", %{conn: conn, chat: chat, user: user} do
      conn =
        conn
        |> session_conn()
        |> put_session(:current_user_id, user.id)
        |> get(Routes.chat_path(conn, :edit, chat))

      assert html_response(conn, 200) =~ "Edit Chat"
    end
  end

  describe "update chat" do
    setup [:create_user]
    setup [:create_chat]

    test "redirects when data is valid", %{conn: conn, chat: chat, user: user} do
      conn =
        conn
        |> session_conn()
        |> put_session(:current_user_id, user.id)
        |> put(Routes.chat_path(conn, :update, chat), chat: @update_attrs)

      assert redirected_to(conn) == Routes.chat_path(conn, :show, chat)

      conn = get(conn, Routes.chat_path(conn, :show, chat))
      assert html_response(conn, 200) =~ "Wolchat"
    end

    test "renders errors when data is invalid", %{conn: conn, chat: chat, user: user} do
      conn =
        conn
        |> session_conn()
        |> put_session(:current_user_id, user.id)
        |> put(Routes.chat_path(conn, :update, chat), chat: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Chat"
    end
  end

  describe "delete chat" do
    setup [:create_user]
    setup [:create_chat]

    test "deletes chosen chat", %{conn: conn, chat: chat, user: user} do
      conn =
        conn
        |> session_conn()
        |> put_session(:current_user_id, user.id)
        |> delete(Routes.chat_path(conn, :delete, chat))

      assert redirected_to(conn) == Routes.chat_path(conn, :index)
    end
  end

  defp create_chat(_) do
    chat = fixture(:chat)
    {:ok, chat: chat}
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
