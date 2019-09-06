defmodule Division.AccountsTest do
  use Division.DataCase

  alias Division.Accounts

  describe "users" do
    alias Division.Accounts.User

    @valid_attrs %{password: "valid password", username: "username"}
    @update_attrs %{password: "some password", username: "newusername"}
    @invalid_attrs %{password: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    defp user_without_password(user) do
      %{id: user.id, username: user.username, avatar: user.avatar}
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      db_users = Enum.map(Accounts.list_users(), fn u -> user_without_password(u) end)
      assert db_users == [user_without_password(user)]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert user_without_password(Accounts.get_user!(user.id)) == user_without_password(user)
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.password == "valid password"
      assert user.username == "username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.password == "some password"
      assert user.username == "newusername"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user_without_password(user) == user_without_password(Accounts.get_user!(user.id))
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
