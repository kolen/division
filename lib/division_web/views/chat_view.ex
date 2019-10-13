defmodule DivisionWeb.ChatView do
  use DivisionWeb, :view

  def addressed_message?(text, username) do
    String.contains?(text, "@#{username}")
  end
end
