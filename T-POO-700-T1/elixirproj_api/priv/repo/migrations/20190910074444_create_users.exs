defmodule Todolist.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password_hash, :string
      add :role, references(:roles, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:role])
    create unique_index(:users, [:email])
  end
end
