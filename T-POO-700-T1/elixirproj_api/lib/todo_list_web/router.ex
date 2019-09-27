defmodule TodolistWeb.Router do
  use TodolistWeb, :router

  alias Todolist.Guardian

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
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  pipeline :is_manager do
    plug TodolistWeb.Plug.Authorisation.AuthManager
  end

  pipeline :is_gen_manager do
    plug TodolistWeb.Plug.Authorisation.AuthGenManager
  end

  ####################################################
  # without token authentification
  ####################################################
  scope "/api", TodolistWeb do
    pipe_through :api

    scope "/users" do
      options "/sign_up", UserController, :options
      post "/sign_up", UserController, :create

      options "/sign_in", UserController, :options
      post "/sign_in", UserController, :sign_in

      options "/log_out", UserController, :options
      get "/log_out", UserController, :log_out
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
      options "/:user_id/:workingtime_id", WorkingtimeController, :options
      get "/:user_id/:workingtime_id", WorkingtimeController, :show_by_uw

      options "/:id", WorkingtimeController, :options
      post "/:user_id", WorkingtimeController, :create_workingtime
      get "/:id", WorkingtimeController, :show_by_use
      put "/:id", WorkingtimeController, :update
      delete "/:id", WorkingtimeController, :delete
    end

    ###############
    # clocks
    ###############
    scope "/clocks" do
      options "/:user_id", ClockController, :options
      get "/:user_id", ClockController, :show_by_u
      post "/:user_id", ClockController, :create_clock
    end

    ###############
    # role
    ###############
    scope "/roles" do
      options "/", RoleController, :options
      get "/", RoleController, :index
    end

    ###############
    # teams
    ###############
    scope "/teams" do
      options "/", TeamController, :options
      get "/", TeamController, :index
      post "/", TeamController, :create

      options "/users/:teamID", TeamController, :options
      get "/users/:teamID", TeamController, :get_users

      options "/workingtimes", TeamController, :options
      get "/workingtimes", TeamController, :get_workingtimes

      options "/:teamID/:userID", UserTeamController, :options
      post "/:teamID/:userID", UserTeamController, :create
      delete "/:teamID/:userID", UserTeamController, :delete
    end
  end
end
