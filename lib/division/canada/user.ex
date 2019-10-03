defimpl Canada.Can, for: Division.Accounts.User do
  # User
  alias Division.Accounts.User

  def can?(%User{id: user_id}, action, %User{id: user_id})
      when action in [:edit, :update],
      do: true

  def can?(%User{}, :read, %User{}), do: true

  # Chats
  alias Division.Chats
  alias Division.Chats.Chat

  def can?(%User{}, :read, %Chat{private: false} = chat) do
    Chats.chat_type(chat) in [:chat]
  end

  # def can?(%User{id: user_id}, :read, %Chat{private: true} = chat) do
  #   case Chats.chat_type(chat) do
  #     :dialog -> Integer.to_string(user_id) in Chats.dialog_user_ids(chat)
  #     _ -> false
  #   end
  # end

  # Default
  def can?(%User{}, _, _), do: false
end
