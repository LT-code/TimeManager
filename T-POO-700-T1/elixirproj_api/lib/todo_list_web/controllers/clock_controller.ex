defmodule TodolistWeb.ClockController do
  use TodolistWeb, :controller
  import Ecto.Query, warn: false
  alias Todolist.Repo

  alias Todolist.Content
  alias Todolist.Content.Clock

  action_fallback TodolistWeb.FallbackController

  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Content.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Content.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  #####################################################################

  def createClock(conn, id, params) do
    changeset = Clock.changeset(%Clock{},
    Map.merge(params, %{"user" => String.to_integer(id), "time" => NaiveDateTime.utc_now()}))
   
    case Repo.insert(changeset) do
      {:ok, clock} ->
        json conn |> put_status(:created), clock
      {:error, _changeset} ->
        json conn |> put_status(:bad_request), %{errors: ["unable to create clock"] }
    end
  end
end
