defmodule Todolist.Repo.Migrations.CreateUsersteams do
  use Ecto.Migration

  def change do
    create table(:usersteams) do #, primary_key: false
      add :user_id, references(:users, on_delete: :delete_all)
      add :team_id, references(:teams, on_delete: :delete_all)

      timestamps()
    end

    create index(:usersteams, [:user_id])
    create index(:usersteams, [:team_id])

    create(
      unique_index(:usersteams, [:user_id, :team_id], name: :user_id_team_id_unique_index)
    )
  end
end
