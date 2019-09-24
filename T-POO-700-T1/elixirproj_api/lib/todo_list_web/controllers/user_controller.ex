defmodule TodolistWeb.UserController do
  use TodolistWeb, :controller
  import Ecto.Query, warn: false
  alias Todolist.Repo
  require Logger

  alias Todolist.Account
  alias Todolist.Account.User
  alias Todolist.Account.Team
  alias Todolist.Guardian

  action_fallback TodolistWeb.FallbackController

  #####################################################################

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.json", users: users)

  end

  #####################################################################

  """
    def create(conn, %{"user" => user_params}) do
      with {:ok, %User{} = user} <- Account.create_user(user_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> render("show.json", user: user)
      end
    end
  """

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
        # {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
      # render("jwt.json", jwt: token)
    end
  end

  #####################################################################
"""
  def show(conn, _params) do
       user = Guardian.Plug.current_resource(conn)
       conn |> render("user.json", user: user)
    end
"""
  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(conn, "show.json", user: user)
  end

  #####################################################################

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user!(id)

    with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
      render(conn, "show.json", user: user)
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
end
