defmodule DivisionWeb.Matrix.ServerDiscoveryView do
  use DivisionWeb, :view
  alias DivisionWeb.Router.Helpers, as: Routes
  alias DivisionWeb.Endpoint

  def render("well_known.json", _) do
    %{
      "m.homeserver":
      %{"base_url": Routes.page_url(Endpoint, :index)},
      "m.identity.server":
      %{"base_url": Routes.page_url(Endpoint, :index)},
    }
  end
end
