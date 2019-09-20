defmodule Todolist.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string
    field :role, :id

    # Virtual fields:
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    # Association
    many_to_many :teams, Team, join_through: "users_teams"

    timestamps()
  end

  @optional_fields ~w(team_id)
  @email ~r/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role, :password, :password_confirmation])
    |> unique_constraint(:email)
    |> validate_required([:username, :email, :role, :password, :password_confirmation])
    |> validate_format(:email, @email, message: "must be a valid email address")
    |> validate_length(:password, min: 8) # Check that password length is >= 8
    |> validate_confirmation(:password) # Check that password === password_confirmation
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
          changeset
    end
  end








  """
  def load_parents(parent) do
    load_parents(parent, 10)
  end

  def load_teams(_, limit) when limit < 0, do: raise "Recursion limit reached"

  def load_teams(%Team{team: nil} = team, _), do: team

  def load_teams(%Team{teams: %Ecto.Association.NotLoaded{}} = teams, limit) do
    teams = Team |> Repo.preload(:teams)
    Map.update!(Team, :teams, &Team.load_teams(&1, limit - 1))
  end

  def load_teams(nil, _), do: nil


  def load_users(user), do: load_users(user, 10)

  def load_users(_, limit) when limit < 0, do: raise "Recursion limit reached"

  def load_users(%User{users: %Ecto.Association.NotLoaded{}} = model, limit) do
    users = User |> Repo.preload(:users) # maybe include a custom query here to preserve some order
    Map.update!(User, :users, fn(list) ->
      Enum.map(list, &User.load_users(&1, limit - 1))
    end)
  end





  def load_parents(parent) do
    load_parents(parent, 10)
  end

  def load_parents(_, limit) when limit < 0, do: raise "Recursion limit reached"

  def load_parents(%Model{parent: nil} = parent, _), do: parent

  def load_parents(%Model{parent: %Ecto.Association.NotLoaded{}} = parent, limit) do
    parent = parent |> Repo.preload(:parent)
    Map.update!(parent, :parent, &Model.load_parents(&1, limit - 1))
  end

  def load_parents(nil, _), do: nil

  def load_children(model), do: load_children(model, 10)

  def load_children(_, limit) when limit < 0, do: raise "Recursion limit reached"

  def load_children(%Model{children: %Ecto.Association.NotLoaded{}} = model, limit) do
    model = model |> Repo.preload(:children) # maybe include a custom query here to preserve some order
    Map.update!(model, :children, fn(list) ->
      Enum.map(list, &Model.load_children(&1, limit - 1))
    end)
  end
  """
end
