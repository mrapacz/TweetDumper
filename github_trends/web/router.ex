defmodule GithubTrends.Router do
  use GithubTrends.Web, :router

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

  scope "/", GithubTrends do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", GithubTrends do
    pipe_through :browser # Use the default browser stack
    get "/:provider", AuthController, :index

    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", GithubTrends do
  #   pipe_through :api
  # end
end
