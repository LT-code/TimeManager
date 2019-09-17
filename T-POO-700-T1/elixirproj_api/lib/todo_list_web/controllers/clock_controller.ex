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

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Res.get_clock!(id)

    with {:ok, %Clock{} = clock} <-
    clock
      |> Clock.changeset(clock_params)
      |> Repo.update()
     do
      render(conn, "show.json", clock: clock)
    end
  end

  #####################################################################

  def show_by_u(conn, %{"user_id" => id}) do
    clock = Repo.get_by!(Clock, user: id)
    render(conn, "show.json", clock: clock)
  end

  #####################################################################

  def post_clock(user_id, time) do
    last_clock =
      Repo.one(
        from c in Clock,
          order_by: [desc: c.time],
          where: c.user == ^user_id,
          select: c,
          limit: 1
      )

    if last_clock === nil do
      Content.create_clock(%{time: time, status: true, user: user_id})
    else
      new_status = !last_clock.status
      if new_status === false do
        Content.create_workingtime(%{start: last_clock.time, end: time, user: user_id})
      end

      Content.update_clock(last_clock, %{time: time, status: new_status, user: user_id})
    end
  end

  #####################################################################

  def create_clock(conn, %{"user_id" => user_id}) do
    actual_time = Elixir.NaiveDateTime.add(Elixir.NaiveDateTime.utc_now(), 7200, :second)

    with {:ok, %Clock{} = clock} <- post_clock(user_id, actual_time) do
      conn
      |> put_status(:created)
      |> render("show.json", clock: clock)
    end
  end
end
