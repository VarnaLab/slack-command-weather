defmodule SlackWeatherCommandWeb.PageController do
  use SlackWeatherCommandWeb, :controller
  alias SlackWeatherCommand.{GoogleApi, DarkskyApi, SlackApi}

  # plug for token

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def valentin(conn, %{"text" => query_string, "response_url" => response_url}) do
    spawn(fn -> compose_answer(query_string, response_url) end)
    text(conn, "It's coming, wait for it!")
  end

  defp compose_answer(query_string, response_url) do
    query_string
    |> GoogleApi.handle()
    |> DarkskyApi.handle()
    |> SlackApi.handle(response_url)
  end
end
