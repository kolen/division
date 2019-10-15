defmodule DivisionWeb.ChatViewTest do
  use DivisionWeb.ConnCase, async: true

  alias DivisionWeb.ChatView

  test "message addressed when contains username start's with @ symbol" do
    style = ChatView.addressed_message?("test @username", "username")
    assert style == "addressed-message"
  end

  test "message not addressed when contains username not start's with @ symbol" do
    style = ChatView.addressed_message?("test", "username")
    assert style == ""
  end
end
