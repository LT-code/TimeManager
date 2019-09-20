defmodule Todolist.Repo.Migrations.CreateUsersteams do
  use Ecto.Migration

  def change do
    create table(:usersteams, primary_key: false) do
      add :user, references(:users, on_delete: :delete_all)
      add :team, references(:teams, on_delete: :delete_all)

      timestamps()
    end

    create index(:usersteams, [:user])
    create index(:usersteams, [:team])
  end
end
