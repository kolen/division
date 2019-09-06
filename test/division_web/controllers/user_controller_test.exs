defmodule DivisionWeb.UserControllerTest do
  use DivisionWeb.ConnCase

  alias Division.Accounts

  @create_attrs %{password: "some_password", username: "goomba"}
  @update_attrs %{password: "some_updated_password", username: "goombaaa"}
  @invalid_attrs %{password: nil, username: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :new))
      response = html_response(conn, 200)
      form_tag_action = response
        |> Floki.find("form")
        |> Floki.attribute("action")

      assert response =~ "Registration"
      assert form_tag_action == ["/register"]
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_path(conn, :show, id)

      conn = get(conn, Routes.user_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show User"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Registration"
    end
  end

  describe "edit user" do
    setup [:create_user]

    test "renders form for editing chosen user", %{conn: conn, user: user} do
      edit_path = Routes.user_path(conn, :edit, user)
      conn = conn
      |> session_conn()
      |> put_session(:current_user_id, user.id)
      |> get(edit_path)
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "update user" do
    setup [:create_user]

    test "redirects when data is valid", %{conn: conn, user: user} do
      conn = conn
      |> session_conn()
      |> put_session(:current_user_id, user.id)
      |> put(Routes.user_path(conn, :update, user), user: @update_attrs)
      assert redirected_to(conn) == Routes.user_path(conn, :show, user)

      conn = get(conn, Routes.user_path(conn, :show, user))
      assert html_response(conn, 200) =~ "goombaaa"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = conn
      |> session_conn()
      |> put_session(:current_user_id, user.id)
      |> put(Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
