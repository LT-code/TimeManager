defmodule TodolistWeb.WorkingtimeController do
  use TodolistWeb, :controller
  import Ecto.Query, warn: false
  alias Todolist.Repo
  require Logger

  alias Todolist.Content
  alias Todolist.Content.Workingtime

  action_fallback TodolistWeb.FallbackController

  #####################################################################

  def create(conn, %{"workingtime" => workingtime_params}) do

    with {:ok, %Workingtime{} = workingtime} <- Content.create_workingtime(workingtime_params) do

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  #####################################################################

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Content.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Content.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  #####################################################################

  def delete(conn, %{"id" => id}) do
    workingtime = Content.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Content.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end

  #####################################################################

  def show_by_use(conn, %{"id" => user_id, "start" => start_value, "end" => end_value}) do
    workingtimes = Workingtime
                    |> where([w], w.user == ^user_id and w.start >= ^start_value and w.end <= ^end_value)
                    |> Repo.all()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  #####################################################################

  def show_by_uw(conn, %{"user_id" => uid, "workingtime_id" => wid}) do
    workingtime = Repo.get_by!(Workingtime, id: wid, user: uid)
    render(conn, "show.json", workingtime: workingtime)
  end

  #####################################################################

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
