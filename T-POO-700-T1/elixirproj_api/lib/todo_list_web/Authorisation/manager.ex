defmodule TodolistWeb.Plug.Authorisation.AuthManager do
  @moduledoc """
  This plug makes sure that the authenticated user is a super user,
  otherwise it halts the connection.
  """
  import Plug.Conn
  import Phoenix.Controller

  alias TodolistWeb.ErrorView
  alias Todolist.Account.User
  alias Todolist.Repo

  require Logger

  def init(opts), do: Enum.into(opts, %{})

  def call(conn, opts \\ []) do
    check_manager(conn, opts)
  end

  defp check_manager(conn, _opts) do
    current_user = Guardian.Plug.current_resource(conn)
    case Repo.get_by(User, %{id: current_user.id, role: 2}) do
      nil -> halt_plug(conn)
      user -> assign(conn, :user, user)
    end
  end

  defp halt_plug(conn) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ErrorView)
    |> render("401.json")
    |> halt()
  end
end
