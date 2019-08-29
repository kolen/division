defmodule Division do
  @moduledoc """
  Division keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def view do
    quote do
      import Chirper.Accounts.Auth, only: [signed_in?: 1]
    end
  end
end
