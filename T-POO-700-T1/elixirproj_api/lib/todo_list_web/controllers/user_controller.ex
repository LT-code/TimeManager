defmodule TodolistWeb.UserController do
  use TodolistWeb, :controller
  import Ecto.Query, warn: false
  alias Todolist.Repo
  require Logger

  alias Todolist.Account
  alias Todolist.Account.User

  action_fallback TodolistWeb.FallbackController

  #####################################################################

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.json", users: users)
  end

  #####################################################################

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  #####################################################################

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(conn, "show.json", user: user)
  end

  #####################################################################

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user!(id)

    if user_params["password"] === nil && user_params["password_confirmation"] === nil do
      with {:ok, %User{} = user} <- Account.update_user_without_password(user, user_params) do
        render(conn, "show.json", user: user)
      end
    else
      with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
        render(conn, "show.json", user: user)
      end
    end
  end

  #####################################################################

  def delete(conn, %{"id" => id}) do
    user = Account.get_user!(id)

    with {:ok, %User{}} <- Account.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  #####################################################################

  def show_by_ue(conn, _params) do
    if conn.query_params["email"] !== nil || conn.query_params["username"] !== nil  do
        user = Repo.get_by!(User, email: conn.query_params["email"], username: conn.query_params["username"])
        render(conn, "show.json", user: user)
    else
        """
        users = User
                |> from()
                |> join(:left, [user], role in assoc(user, :roles))
                |> preload([user, role], [roles: role])
                |> Repo.all()
        """
        users = Account.list_users()
        render(conn, "index.json", users: users)
    end
  end

  #####################################################################

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Todolist.Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end

  #####################################################################

  def log_out(conn, params) do
    Todolist.Accounts.token_sign_out(conn, params)
    {:ok, :log_out}
  end
end
