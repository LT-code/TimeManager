defmodule TodolistWeb.TeamController do
  use TodolistWeb, :controller

  alias Todolist.Account
  alias Todolist.Account.Team

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    teams = Account.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- Account.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Account.get_team!(id)
    render(conn, "show.json", team: team)

    show(id)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Account.get_team!(id)

    with {:ok, %Team{} = team} <- Account.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Account.get_team!(id)

    with {:ok, %Team{}} <- Account.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end


  def show(id) do
    model = Repo.get(User, id)
      |> Team.load_users

    # rendering, etc...
  end
end
