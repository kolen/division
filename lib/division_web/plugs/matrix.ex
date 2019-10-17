defmodule DivisionWeb.Plugs.Matrix do
  def init(opts), do: opts

  def call(conn, _) do
    set_cors_headers(conn)
  end

  defp set_cors_headers(conn) do
    # Allow Matrix endpoint to be used from web clients, see
    # https://matrix.org/docs/spec/client_server/r0.5.0#web-browser-clients
    Plug.Conn.merge_resp_headers conn,
      [
	{"Access-Control-Allow-Origin",
	 "*"},
	{"Access-Control-Allow-Methods",
	 "GET, POST, PUT, DELETE, OPTIONS"},
	{"Access-Control-Allow-Headers",
	 "Origin, X-Requested-With, Content-Type, Accept, Authorization"}
      ]
  end
end
