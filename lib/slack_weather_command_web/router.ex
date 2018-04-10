defmodule SlackWeatherCommandWeb.Router do
  use SlackWeatherCommandWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    # plug :protect_from_forgery
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", SlackWeatherCommandWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    post("/valentin", PageController, :valentin)
  end

  # Other scopes may use custom stacks.
  # scope "/api", SlackWeatherCommandWeb do
  #   pipe_through :api
  # end
end
