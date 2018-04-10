defmodule SlackWeatherCommand.GoogleApi do
  def handle(query_string) do
    "https://maps.googleapis.com/maps/api/geocode/json?address=#{query_string}&key=#{System.get_env("GOOGLE_KEY")}"
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Poison.decode!()
    |> Map.get("results")
    |> hd()
    |> get_in(["geometry", "location"])
  end
end
