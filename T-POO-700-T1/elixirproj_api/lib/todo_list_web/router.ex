defmodule TodolistWeb.Router do
  use TodolistWeb, :router

  alias Todolist.Guardian
  alias Todolist.Guardian.AuthPipeline

  ####################################################
  #	No rout error
  ####################################################
  defmodule NoRouteError do
    @moduledoc """
    Exception raised when no route is found.
    """
    defexception plug_status: 404, message: "no route found", conn: nil, router: nil

    def exception(opts) do
      conn   = Keyword.fetch!(opts, :conn)
      router = Keyword.fetch!(opts, :router)
      path   = "/" <> Enum.join(conn.path_info, "/")

      %NoRouteError{message: "no route found for #{conn.method} #{path} (#{inspect router})",
                    conn: conn, router: router}
    end
  end


  ####################################################
  #	pipeline
  ####################################################
  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end


  ####################################################
  # without token authentification
  ####################################################
  scope "/api", TodolistWeb do
    pipe_through :api

    scope "/users" do
      post "/sign_up", UserController, :create
      post "/sign_in", UserController, :sign_in
    end
  end


  ####################################################
  # with token authentification
  ####################################################
  scope "/api", TodolistWeb do
    pipe_through [:api, :jwt_authenticated]

    ###############
    # uers
    ###############
    scope "/users" do
      options "/", UserController, :options
      get "/", UserController, :show_by_ue
      post "/", UserController, :create

      options "/:id", UserController, :options
      get "/:id", UserController, :show
      put "/:id", UserController, :update
      delete "/:id", UserController, :delete
    end

    ###############
    # workingtimes
    ###############
    scope "/workingtimes" do
      get "/:user_id/:workingtime_id", WorkingtimeController, :show_by_uw
      get "/:id", WorkingtimeController, :show_by_use
      put "/:id", WorkingtimeController, :update
      delete "/:id", WorkingtimeController, :delete
      post "/:user_id", WorkingtimeController, :create_workingtime
    end

    ###############
    # clocks
    ###############
    scope "/clocks" do
      get "/:user_id", ClockController, :show_by_u
      post "/:user_id", ClockController, :create_clock
    end
  end
end
