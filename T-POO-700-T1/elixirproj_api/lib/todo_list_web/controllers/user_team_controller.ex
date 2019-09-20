defmodule TodolistWeb.UserTeamController do
  use TodolistWeb, :controller

  alias Todolist.Association
  alias Todolist.Association.UserTeam

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    usersteams = Association.list_usersteams()
    render(conn, "index.json", usersteams: usersteams)
  end

  def create(conn, %{"user_team" => user_team_params}) do
    with {:ok, %UserTeam{} = user_team} <- Association.create_user_team(user_team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_team_path(conn, :show, user_team))
      |> render("show.json", user_team: user_team)
    end
  end

  def show(conn, %{"id" => id}) do
    user_team = Association.get_user_team!(id)
    render(conn, "show.json", user_team: user_team)
  end

  def update(conn, %{"id" => id, "user_team" => user_team_params}) do
    user_team = Association.get_user_team!(id)

    with {:ok, %UserTeam{} = user_team} <- Association.update_user_team(user_team, user_team_params) do
      render(conn, "show.json", user_team: user_team)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_team = Association.get_user_team!(id)

    with {:ok, %UserTeam{}} <- Association.delete_user_team(user_team) do
      send_resp(conn, :no_content, "")
    end
  end
end
