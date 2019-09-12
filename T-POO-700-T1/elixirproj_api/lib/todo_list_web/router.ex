defmodule TodolistWeb.Router do
  use TodolistWeb, :router

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


  scope "/api", TodolistWeb do
    pipe_through :api

    ###############
    # uers
    ###############
    options "/users", UserController, :options
    get "/users", UserController, :show_by_ue
    post "/users", UserController, :create

    options "/users:id", UserController, :options
    get "/users/:id", UserController, :show
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete


    ###############
    # workingtimes
    ###############
    get "/workingtimes/:userID", WorkingtimeController, :show_by_use
    get "/workingtimes/:id", WorkingtimeController, :show_by_uw
    put "/workingtimes/:id", WorkingtimeController, :update
    delete "/workingtimes/:id", WorkingtimeController, :delete
    post "/workingtimes/:id", WorkingtimeController, :create_workingtime

    ###############
    # clocks
    ###############

    get "/clocks/:id", ClockController, :show
    post "/clocks/:id", ClockController, :createClock
  end
end
