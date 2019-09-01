defmodule DivisionWeb.ChatLiveView do
  use Phoenix.LiveView
  alias Division.Chats

  defp topic(chat_id), do: "chat:#{chat_id}"

  def render(assigns) do
    DivisionWeb.ChatView.render("show.html", assigns)
  end

  def mount(%{chat: chat, current_user: current_user}, socket) do
    DivisionWeb.Endpoint.subscribe(topic(chat.id))

    {:ok,
     assign(socket,
       chat: chat,
       message: Chats.change_message(),
       current_user: current_user
     )}
  end

  def handle_info(%{event: "message", payload: state}, socket) do
    {:noreply, assign(socket, state)}
  end

  def handle_event("message", %{"message" => %{"content" => ""}}, socket) do
    {:noreply, socket}
  end

  def handle_event("message", %{"message" => message_params}, socket) do
    {:ok, message} = Chats.create_message(message_params)
    chat = Chats.get_chat_with_messages(message.chat_id)
    DivisionWeb.Endpoint.broadcast_from(self(), topic(chat.id), "message", %{chat: chat})
    {:noreply, assign(socket, chat: chat, message: Chats.change_message())}
  end

  def handle_event("typing", _value, socket = %{assigns: %{chat: chat, current_user: user}}) do
    {:noreply, socket}
  end

  def handle_event(
        "stop_typing",
        value,
        socket = %{assigns: %{chat: chat, current_user: user, message: message}}
      ) do
    message = Chats.change_message(message, %{content: value})
    {:noreply, assign(socket, message: message)}
  end
end
