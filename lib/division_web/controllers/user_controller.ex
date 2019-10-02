defmodule DivisionWeb.UserController do
  use DivisionWeb, :controller

  import Canada, only: [can?: 2]
  import Ecto.Query, warn: false

  alias Division.Accounts
  alias Division.Accounts.User
  alias Division.Chats.Chat
  alias Division.Chats.Message

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params |> Map.delete("avatar")) do
      {:ok, user} ->
        Accounts.update_user(user, %{"avatar" => user_params["avatar"]})

        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Registered successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => user_id}) do
    you = conn.assigns[:current_user]

    msg_query =
      from msg in Message,
        limit: 6,
        order_by: [desc: msg.inserted_at],
        preload: [:user]

    chat_query =
      from c in Chat,
        preload: [messages: ^msg_query]

    query =
      from u in User,
        where: u.id == ^user_id,
        preload: [chat: ^chat_query]

    user = Division.Repo.one(query)

    if you |> can?(read(user)) do
      conn
      |> render("show.html", user: user, chat: user.chat)
    else
      conn
      |> put_flash(:info, "Fuck you.")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    if conn.assigns[:current_user] |> can?(edit(user)) do
      changeset = Accounts.change_user(user)

      conn
      |> render("edit.html", user: user, changeset: changeset)
    else
      conn
      |> put_flash(:info, "You can't edit this user.")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    if conn.assigns[:current_user] |> can?(update(user)) do
      case Accounts.update_user(user, user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User updated successfully.")
          |> redirect(to: Routes.user_path(conn, :show, user))

        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> render("edit.html", user: user, changeset: changeset)
      end
    else
      conn
      |> put_flash(:info, "You can't edit this user.")
      |> redirect(to: Routes.user_path(conn, :show, user))
    end
  end

  # def delete(conn, %{"id" => id}) do
  #   user = Accounts.get_user!(id)
  #   {:ok, _user} = Accounts.delete_user(user)

  #   conn
  #   |> put_flash(:info, "User deleted successfully.")
  #   |> redirect(to: Routes.user_path(conn, :index))
  # end
end
