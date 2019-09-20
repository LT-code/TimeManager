defmodule TodolistWeb.UserTeamView do
  use TodolistWeb, :view
  alias TodolistWeb.UserTeamView

  def render("index.json", %{usersteams: usersteams}) do
    %{data: render_many(usersteams, UserTeamView, "user_team.json")}
  end

  def render("show.json", %{user_team: user_team}) do
    %{data: render_one(user_team, UserTeamView, "user_team.json")}
  end

  def render("user_team.json", %{user_team: user_team}) do
    %{id: user_team.id}
  end
end
