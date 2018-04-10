defmodule SlackCommandWeatherWeb.Router do
  use SlackCommandWeatherWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
   # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SlackCommandWeatherWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    post "/georgi", PageController, :slack_weather
  end

  # Other scopes may use custom stacks.
  # scope "/api", SlackCommandWeatherWeb do
  #   pipe_through :api
  # end
end
