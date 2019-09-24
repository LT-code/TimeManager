defmodule TodolistWeb.TeamView do
  use TodolistWeb, :view
  alias TodolistWeb.TeamView
  alias TodolistWeb.UserTeamView


  ###########
  # simple
  ###########

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{id: team.id,
      name: team.name}
  end

  ###########
  # assoc get users
  ###########

  def render("index_users.json", %{teams: teams}) do
    %{data: render_many(teams, TeamView, "team_users.json")}
  end

  def render("team_users.json", %{team: team}) do
    %{id: team.id,
      name: team.name,
      users: render_many(team.users, TodolistWeb.UserView, "user.json", as: :user)}
  end

  ###########
  # assoc get workingtimes
  ###########

  def render("index_workingtimes.json", %{teams: teams}) do
    %{data: render_many(teams, TeamView, "team_workingtimes.json")}
  end

  def render("team_workingtimes.json", %{team: team}) do
    %{id: team.id,
      name: team.name,
      users: render_many(team.users, TodolistWeb.UserView, "user_workingtimes.json", as: :user)}
  end
end
