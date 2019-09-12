defmodule TodolistWeb.WorkingtimeController do
  use TodolistWeb, :controller
  import Ecto.Query, warn: false
  alias Todolist.Repo
  require Logger

  alias Todolist.Content
  alias Todolist.Content.Workingtime

  action_fallback TodolistWeb.FallbackController

  def create(conn, %{"workingtime" => workingtime_params}) do

    with {:ok, %Workingtime{} = workingtime} <- Content.create_workingtime(workingtime_params) do

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Content.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Content.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Content.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Content.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end

  #####################################################################

  def show_by_use(conn, %{"userID" => user}) do
    workingtime = Repo.get_by!(User, start: conn.query_params["start"], end: conn.query_params["end"], user: user)
    render(conn, "show.json", workingtime: workingtime)
  end

  #####################################################################

  def show_by_uw(conn, %{"userID" => uid, "workingtimeID" => wid}) do
    wrokingtime = Repo.get_by!(Workingtime, user: uid, id: wid)
    render(conn, "show.json", wrokingtime: wrokingtime)
  end

  #####################################################################

  def create_workingtime(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    changeset = Workingtime.changeset(%Workingtime{}, %{user: id, end: workingtime_params["end"], start: workingtime_params["start"]})
    
    case Repo.insert(changeset) do
      {:ok, workingtime} ->
        json conn |> put_status(:created), workingtime
      {:error, _changeset} ->
        json conn |> put_status(:bad_request), %{errors: ["unable to create workingtime"] }
    end
  end
end
