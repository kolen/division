defmodule DivisionWeb.Matrix.SessionView do
  use DivisionWeb, :view
  alias DivisionWeb.Router.Helpers, as: Routes
  alias DivisionWeb.Endpoint

  def render("show.json", _) do
    %{
      "flows": [
	%{"type": "m.login.password"}
      ]
    }
  end

  def render("login_fail.json", %{message: message, errcode: errcode}) do
    %{
      "errcode": errcode,
      "error": message
    }
  end

  def render("login_success.json", %{user_id: user_id,
				     access_token: access_token,
				     device_id: device_id}) do
    %{
      "user_id" => user_id,
      "access_token" => access_token,
      "device_id" => device_id,
      "well_known" => %{
	"m.homeserver" => %{"base_url" => Routes.page_url(Endpoint, :index)},
	"m.identity_server" => %{"base_url" => Routes.page_url(Endpoint, :index)}
      }
    }
  end
end
