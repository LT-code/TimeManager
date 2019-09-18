defmodule Todolist.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password, :string
      add :role, references(:roles, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:role])
  end
end
