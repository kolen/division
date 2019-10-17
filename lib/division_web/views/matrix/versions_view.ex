defmodule DivisionWeb.Matrix.VersionsView do
  use DivisionWeb, :view

  def render("versions.json", _) do
    %{"versions": ["r0.5.0"]}
  end
end
