defmodule Todolist.Accounts do
  # code omitted for brevity

  alias Todolist.Guardian
  alias Todolist.Repo
  alias Todolist.Account.User
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  require Logger

  defp get_by_email(email) when is_binary(email) do
    Logger.info("get_by_email")
    case Repo.get_by(User, email: email) do
      nil ->
        Logger.info("dummy")
        dummy_checkpw()

        {:error, "Login error."}
      user ->
        Logger.info(inspect(user))
        {:ok, user}
    end

  end
  defp verify_password(password, %User{} = user) when is_binary(password) do
    Logger.info("verify_password")
    if checkpw(password, user.password_hash) do
      Logger.info(password)
      {:ok, user}
    else
      {:error, :invalid_password}
    end

  end
  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
         with {:ok, user} <- get_by_email(email),
    do: verify_password(password, user)
  end

  def token_sign_in(email, password) do
    case email_password_auth(email, password) do
      {:ok, user} ->
        Guardian.encode_and_sign(user)
      _ ->
        {:error, :unauthorized}
    end
  end

  def token_sign_out(conn, params) do
    jwt = Guardian.Plug.current_token(conn)
    Guardian.revoke(jwt)
    {:ok, :revoked}
  end
end
