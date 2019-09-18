defmodule DivisionWeb.AccessControllerTest do
  use DivisionWeb.ConnCase

  alias Division.Chats

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:access) do
    {:ok, access} = Chats.create_access(@create_attrs)
    access
  end

  defp create_access(_) do
    access = fixture(:access)
    {:ok, access: access}
  end
end
