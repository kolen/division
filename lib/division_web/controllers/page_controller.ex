defmodule DivisionWeb.PageController do
  use DivisionWeb, :controller
  alias Division.Chats
  alias Division.Accounts

  plug :get_user_from_session

  def index(conn, _params) do
    chats = Chats.list_chats()
    users = Accounts.list_users()
    render(conn, "index.html", chats: chats, users: users)
  end

  defp get_user_from_session(conn, _) do
    DivisionWeb.Plugs.Auth.get_user_from_session(conn, {})
  end
end
