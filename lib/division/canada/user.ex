defimpl Canada.Can, for: Division.Accounts.User do
  # User
  alias Division.Accounts.User

  def can?(%User{id: user_id}, action, %User{id: user_id})
      when action in [:edit, :update],
      do: true

  def can?(%User{}, :read, %User{}), do: true

  # Chats
  alias Division.Chats.Chat

  def can?(%User{}, :read, %Chat{private: false}), do: true

  # Default
  def can?(%User{}, _, _), do: false
end
