defmodule DivisionWeb.ChatView do
  use DivisionWeb, :view

  def addressed_message?(message, username) do
    cond do
      String.contains?(message, "@#{username}") -> "addressed-message"
      true -> ""
    end
  end
end
