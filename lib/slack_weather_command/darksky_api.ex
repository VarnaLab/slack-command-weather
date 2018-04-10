defmodule SlackWeatherCommand.DarkskyApi do
  def handle(%{"lat" => lat, "lng" => lng}) do
    "https://api.darksky.net/forecast/#{System.get_env("DARKSKY_KEY")}/#{lat},#{lng}"
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Poison.decode!()
    |> Map.get("currently")
  end
end
