defimpl Canada.Can, for: Division.Accounts.User do
  alias Division.Accounts.User

  def can?(%User{id: user_id}, action, %User{id: user_id})
  when action in [:edit, :update], do: true

  def can?(%User{}, :read, %User{}), do: true

  def can?(%User{}, _, %User{}), do: false
end
