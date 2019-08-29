defmodule DivisionWeb.PageController do
  use DivisionWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
