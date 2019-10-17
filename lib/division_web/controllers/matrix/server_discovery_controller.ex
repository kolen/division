defmodule DivisionWeb.Matrix.ServerDiscoveryController do
  use DivisionWeb, :controller # TODO: check if should use DivisionWeb.Matrix

  def well_known(conn, _params) do
    render conn, "well_known.json"
  end
end
