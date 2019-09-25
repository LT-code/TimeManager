defmodule Todolist.Account.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string

    many_to_many(
      :users,
      Todolist.Account.User,
      join_through: "usersteams",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

end
