defmodule TodolistWeb.ClockController do
  use TodolistWeb, :controller
  import Ecto.Query, warn: false
  alias Todolist.Repo

  alias Todolist.Content
  alias Todolist.Content.Clock

  action_fallback TodolistWeb.FallbackController

  #####################################################################

  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Content.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  #####################################################################

  def show_by_u(conn, %{"user_id" => id}) do
    clock = Repo.get_by!(Clock, user: id)
    render(conn, "show.json", clock: clock)
  end

  #####################################################################

  def create_clock(conn, %{"user_id" => id}) do
    time = Elixir.NaiveDateTime.add(Elixir.NaiveDateTime.utc_now(), 7200, :second)

    with {:ok, %Clock{} = clock} <- Res.post_clock(user_id, time) do
      conn
      |> put_status(:created)
      |> render("show.json", clock: clock)
    end

    with {:ok, %Clock{} = clock} <-
          %Clock{}
          |> Clock.changeset(%{start: w,end: w, user: id})
          |> Repo.insert()
        do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end


  def create_workingtime(conn, %{"user_id" => user_id, "workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <-
          %Workingtime{}
          |> Workingtime.changeset(%{start: workingtime_params["start"],end: workingtime_params["end"], user: user_id})
          |> Repo.insert()
        do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end
end
