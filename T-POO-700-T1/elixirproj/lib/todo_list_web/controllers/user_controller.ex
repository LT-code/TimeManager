defmodule TodolistWeb.UserController do
  use TodolistWeb, :controller
  import Ecto.Query, warn: false
  alias Todolist.Repo
  require Logger

  alias Todolist.Account
  alias Todolist.Account.User

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user!(id)

    with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Account.get_user!(id)

    with {:ok, %User{}} <- Account.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  #####################################################################

  def show_by_ue(conn, _params) do
    Logger.info("coucou")
    Logger.info(inspect(conn, pretty: true))

    case conn.query_params["email"] !== nil do
      true ->
        user = Repo.get_by!(User, email: conn.query_params["email"], username: conn.query_params["username"])
        render(conn, "show.json", user: user)
      false ->
        users = Account.list_users()
        render(conn, "index.json", users: users)
    end

    #if conn.query_params["email"] !== nil | conn.query_params["email"] !== nil do
    #  user = Repo.get_by(User, email: conn.query_params["email"], username: conn.query_params["username"])
    #  render(conn, "show.json", user: user)
    #end

  end
end
