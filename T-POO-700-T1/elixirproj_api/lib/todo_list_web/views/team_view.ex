defmodule TodolistWeb.TeamView do
  use TodolistWeb, :view
  alias TodolistWeb.TeamView
  alias TodolistWeb.UserTeamView


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

  def render("team_all.json", %{teams: teams}) do
    render("team.json", %{teams: teams})
    |> Map.put_new(:usersteams, render_one(teams.usersteams, Todolist.UserTeamView, "user_team_all.json", as: :user_team))
  end
end
