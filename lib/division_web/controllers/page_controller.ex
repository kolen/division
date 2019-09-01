defmodule DivisionWeb.PageController do
  use DivisionWeb, :controller
  alias Division.Chats
  alias Division.Accounts

  def index(conn, _params) do
    chats = Chats.list_chats
    users = Accounts.list_users
    render(conn, "index.html", chats: chats, users: users)
  end
end
