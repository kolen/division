defmodule DivisionWeb.Matrix.SessionController do
  use DivisionWeb, :controller

  alias Division.Accounts.Auth
  alias Division.Repo

  def show(conn, _params) do
    render conn, "show.json"
  end

  def create(conn, %{"type" => "m.login.password",
		     "identifier" => %{"type" => "m.id.user", "user" => username},
		     "password" => password}) do
    # https://matrix.org/docs/spec/client_server/r0.5.0#post-matrix-client-r0-login
    case Auth.login(%{"username" => username, "password" => password}, Repo) do
      {:ok, user} ->
	render(conn, "login_success.json",
	  user_id: "@#{username}:foo.org", # FIXME: domain
	  access_token: "foobar", # FIXME: proper token
	  device_id: "devicelol" # FIXME: generate device id or use if request has it
	)
      :error ->
	conn
	|> put_status(400)
	|> render "login_fail.json", message: "Invalid credentials", errcode: "M_FORBIDDEN"
    end
  end
  def create(conn, _) do
    conn
    |> put_status(400)
    |> render "login_fail.json", message: "Bad login", errcode: "M_BAD_JSON"
  end
end
