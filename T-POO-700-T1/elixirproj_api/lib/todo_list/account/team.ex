defmodule Todolist.Account.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    many_to_many :users, Users, join_through: "users_teams"

    timestamps()
  end

  @optional_fields ~w(user_id)

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

    """
  def load_users(model), do: load_users(model, 10)

  def load_users(_, limit) when limit < 0, do: raise "Recursion limit reached"

  def load_users(%Team{users: %Ecto.Association.NotLoaded{}} = model, limit) do
    model
        |> Repo.preload(:users) # maybe include a custom query here to preserve some order
        |> Map.update!(model, :users, fn(list) ->
            Enum.map(list, fn(c) -> c |> User.load_teams(limit - 1) |> User.load_teams(limit-1) end)
           end)
  end





  def load_comments(model), do: load_comments(model, 10)

  def load_comments(_, limit) when limit < 0, do: raise "Recursion limit reached"

  def load_comments(%Post{comments: %Ecto.Association.NotLoaded{}} = model, limit) do
    model
        |> Repo.preload(:comments) # maybe include a custom query here to preserve some order
        |> Map.update!(model, :comments, fn(list) ->
            Enum.map(list, fn(c) -> c |> Comment.load_parents(limit - 1) |> Comment.load_children(limit-1) end)
           end)
  end
  """
end
