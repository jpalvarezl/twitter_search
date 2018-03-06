defmodule AuthService do

  @auth_url "https://api.twitter.com/oauth2/token"

  def get_bearer_token() do
    headers = [{"Authorization", generate_auth()},
    {"Content-Type", "application/x-www-form-urlencoded;charset=UTF-8"}]
    body = "grant_type=client_credentials"
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]

    {:ok, response} = HTTPoison.post(@auth_url, body, headers,options)
    decode_auth_token(response.body)
  end

  defp generate_auth() do
    consumer_key = Application.get_env(:twitter_search, :consumer_key)
    consumer_secret = Application.get_env(:twitter_search, :consumer_secret)
    "Basic "<>Base.encode64(consumer_key<>":"<>consumer_secret)
  end

  defp decode_auth_token(body) do
    auth = body |> Poison.decode!
    auth["access_token"]
  end

end
