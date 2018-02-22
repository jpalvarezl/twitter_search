defmodule TwitterApi do

  @auth_url "https://api.twitter.com/oauth2/token"

  defp get_auth() do
    consumer_key = Application.get_env(:twitter_search, :consumer_key)
    consumer_secret = Application.get_env(:twitter_search, :consumer_secret)
    "Basic "<>Base.encode64(consumer_key<>":"<>consumer_secret)
  end

  def post_auth() do
    headers = [{"Authorization", get_auth()},
      {"Content-Type", "application/x-www-form-urlencoded;charset=UTF-8"}]
    body = "grant_type=client_credentials"
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]

    {:ok, response} = HTTPoison.post(@auth_url, body, headers,options)
    decode_auth_token(response.body)
  end

  def decode_auth_token(body) do
    body
    |> Poison.decode!
    |> Map.take(["token_type", "access_token"])
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  # def get_twitts do
  #   token = "some_token_from_another_request"
  #   url = "https://api.twitter.com/1.1/search/tweets.json"
  #   headers = ["Authorization": "Bearer #{token}", "Accept": "Application/json; Charset=utf-8"]
  #   options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]
  #   {:ok, response} = HTTPoison.get(url, headers, options)
  #   IO.inspect response.body
  # end
end
