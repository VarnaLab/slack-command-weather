defmodule SlackCommandWeatherWeb.PageController do
  use SlackCommandWeatherWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def slack_weather(conn, params) do
    %{"text" => city, "response_url" => response} = params

    get_weather_data =
    fn ->
      city
      |> build_google_url()
      |> get_data_from_google()
      |> get_long_lang()
      |> build_weather_url()
      |> get_data_from_darksky()
      |> format_weather_data()
      |> build_slack_attachment()
      |> Poison.encode!()
      |> build_slack_post_request(response)
    end
    Task.start(get_weather_data)

    text conn, "Hello"
  end


  def build_google_url(city) do
    first_part_url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    end_part_url = "&key=AIzaSyD1mMuU_7DRj6u8phQ25gFP5Td12XKJ6mw"

    first_part_url <> city <> end_part_url
  end

  def get_data_from_google(path), do: HTTPoison.get!(path)

  def get_long_lang(%HTTPoison.Response{body: body}) do
    info = Poison.decode!(body)
    %{"results" => [h | t]} = info
    %{"geometry" => %{"location" => %{"lat" => latitude, "lng" => lognitude}}} = h
    to_string(latitude) <> "," <> to_string(lognitude)
  end

  def build_weather_url(lat_long) do
    first_part_url = "https://api.darksky.net/forecast/ee1b8b7bb30ec66ca11b8a59d9e2d45d/"
    last_part_url = "?lang=bg&units=si"
    first_part_url <> lat_long <> last_part_url
  end

  def get_data_from_darksky(path), do: HTTPoison.get!(path)

  def format_weather_data(%HTTPoison.Response{body: body}) do
    info = Poison.decode!(body)

    %{"currently" => %{"summary" => summary,
                       "temperature" => temperature,
                       "windSpeed" => wind}} = info

    "Времето е с #{summary}, температурата е #{temperature} градуса, а скоростта на вятъра е #{wind}"
  end

  def build_slack_attachment(text) do
    %{"attachments" => [%{"text" => text}]}
  end

  def build_slack_post_request(body, link) do
    HTTPoison.post(link, body, [{"Content-Type", "application/json"}])
  end
end
