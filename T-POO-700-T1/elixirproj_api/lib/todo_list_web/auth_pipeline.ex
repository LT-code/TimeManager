defmodule Todolist.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :Todolist,
  module: Todolist.Guardian,
  error_handler: Todolist.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
