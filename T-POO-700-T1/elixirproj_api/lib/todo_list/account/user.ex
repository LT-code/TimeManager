defmodule Todolist.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string
    field :role, :id

    timestamps()
  end

  @email ~r/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role, :password])
    |> validate_required([:username, :email, :role, :password])
    |> validate_format(:email, @email, message: "must be a valid email address")
  end
  
  """
    def changeset(%User{} = user, attrs) do
      user
      |> cast(attrs, [:email, :password, :password_confirmation]) # Remove hash, add pw + pw confirmation
      |> validate_required([:email, :password, :password_confirmation]) # Remove hash, add pw + pw confirmation
      |> validate_format(:email, ~r/@/) # Check that email is valid
      |> validate_length(:password, min: 8) # Check that password length is >= 8
      |> validate_confirmation(:password) # Check that password === password_confirmation
      |> unique_constraint(:email)
    end
  """
end
