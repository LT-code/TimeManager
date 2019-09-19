<<<<<<< HEAD
defmodule Todolist.Guardian do
  use Guardian, otp_app: :Todolist
=======
defmodule MyApi.Guardian do
  use Guardian, otp_app: :myApi
>>>>>>> 92c46c4dc4fcc293ffac3229e2e557374878abfb

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
<<<<<<< HEAD
    resource = Todolist.Account.get_user!(id)
=======
    resource = MyApi.Accounts.get_user!(id)
>>>>>>> 92c46c4dc4fcc293ffac3229e2e557374878abfb
    {:ok,  resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
