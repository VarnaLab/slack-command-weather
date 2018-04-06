
# Elixir Project 2: Create Weather Forecast Slack /slash Command

1. Create HTTP server that listens on port `4000`
2. Use `/yourname [location]` Slack command to send a string to your server
3. Pipe the received string location to the Google's [Geocoding API](https://developers.google.com/maps/documentation/geocoding/start)
4. Pipe the returned `lat,lng` coordinates to the DarkSky's [Weather API](https://darksky.net/dev/)
5. Map the weather forecast data to [Slack Attachment](https://api.slack.com/docs/message-attachments) JSON object
6. Send it back to Slack

# Tips

- Use the [Google Cloud Platform](https://console.cloud.google.com) to create API key for the Geocoding API
- The request URL for the Geocoding API is: `https://maps.googleapis.com/maps/api/geocode/json`
- Go to [DarkSky](https://darksky.net/dev) to create API key for the Weather Forecast API
- The request URL for the Weather Forecast API is: `https://api.darksky.net/forecast/[api_key]/[lat,lng]`
- Example Slack Attachment:

![](https://i.imgur.com/otI4Hbu.png)

- Send feedback back to your users immediately (the grey line above), send the attachment to the `response_url` of the request body when ready
