defmodule TodolistWeb.RoleController do
  use TodolistWeb, :controller

  alias Todolist.Security
  alias Todolist.Security.Role

  action_fallback TodolistWeb.FallbackController

  #####################################################################

  def index(conn, _params) do
    roles = Security.list_roles()
    render(conn, "index.json", roles: roles)
  end

  #####################################################################

  def create(conn, %{"role" => role_params}) do
    with {:ok, %Role{} = role} <- Security.create_role(role_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.role_path(conn, :show, role))
      |> render("show.json", role: role)
    end
  end

  #####################################################################

  def show(conn, %{"id" => id}) do
    role = Security.get_role!(id)
    render(conn, "show.json", role: role)
  end

  #####################################################################

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Security.get_role!(id)

    with {:ok, %Role{} = role} <- Security.update_role(role, role_params) do
      render(conn, "show.json", role: role)
    end
  end

  #####################################################################

  def delete(conn, %{"id" => id}) do
    role = Security.get_role!(id)

    with {:ok, %Role{}} <- Security.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end
end
