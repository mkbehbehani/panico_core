defmodule PanicoCore.Router do
  use PanicoCore.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PanicoCore do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/releases", ReleaseController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PanicoCore do
  #   pipe_through :api
  # end
end
