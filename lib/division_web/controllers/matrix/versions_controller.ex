defmodule DivisionWeb.Matrix.VersionsController do
  use DivisionWeb, :controller

  def index(conn, _params) do
    render conn, "versions.json"
  end
end
