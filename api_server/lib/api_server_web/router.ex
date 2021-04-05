defmodule ApiServerWeb.Router do
  use ApiServerWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :api do
    plug :accepts, ["json"]
    plug ApplicationWeb.Context
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: ApiServerWeb.Schema

    forward "/", Absinthe.Plug,
      schema: ApiServerWeb.Schema
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).

  # For this application we simply expose it

  scope "/" do
    pipe_through [:fetch_session, :protect_from_forgery]
    live_dashboard "/dashboard", metrics: ApiServerWeb.Telemetry
  end
end
