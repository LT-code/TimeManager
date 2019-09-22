defmodule Todolist.Association.UserTeam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "usersteams" do
    belongs_to :user, Todolist.Account.User
    belongs_to :team, Todolist.Account.Team

    timestamps()
  end

  @doc false
  def changeset(user_team, attrs) do
    user_team
    |> cast(attrs, [:user_id, :team_id])
    |> validate_required([:user_id, :team_id])
  end
end
