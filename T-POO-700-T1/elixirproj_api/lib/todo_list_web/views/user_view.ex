defmodule TodolistWeb.UserView do
  use TodolistWeb, :view
  alias TodolistWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      role: user.role}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end


  def render("user_workingtimes.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
      workingtimes: render_many(user.workingtimes, TodolistWeb.WorkingtimeView, "workingtime.json", as: :workingtime)
    }
  end

  def render("index_roles.json", %{users: users}) do
    %{data: render_many(users, UserView, "user_roles.json")}
  end

  def render("user_roles.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      role: render_one(user.role, TodolistWeb.RoleView, "role.json", as: :role)}
  end

  #  role_id: user.role,
end
