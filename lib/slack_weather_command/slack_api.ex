defmodule SlackWeatherCommand.SlackApi do
  def handle(%{"summary" => title, "temperature" => text} = weather_data, response_url) do
    body =
      %{
        "attachments" => [
          %{
            "title" => title,
            "text" => text
          }
        ]
      }
      |> Poison.encode!()

    HTTPoison.post(response_url, body, [
      {"Content-Type", "application/json"}
    ])
  end
end
