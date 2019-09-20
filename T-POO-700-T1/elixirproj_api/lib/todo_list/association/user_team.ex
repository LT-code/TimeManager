defmodule Todolist.Association.UserTeam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "usersteams" do
    field :user, :id
    field :team, :id

    belongs_to :users, Todolist.Account.User
    belongs_to :teams, Todolist.Account.Team

    timestamps()
  end

  @optional_fields ~w(team, user)

  @doc false
  def changeset(user_team, attrs) do
    user_team
    |> cast(attrs, [])
    |> validate_required([])
  end
end
