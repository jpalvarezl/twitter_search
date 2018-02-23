defmodule TwitterApi do

  @auth_url "https://api.twitter.com/oauth2/token"
  @token_fields ["token_type", "access_token"]
  @tweet_fields ["created_at","text", "user"]

  defp generate_auth() do
    consumer_key = Application.get_env(:twitter_search, :consumer_key)
    consumer_secret = Application.get_env(:twitter_search, :consumer_secret)
    "Basic "<>Base.encode64(consumer_key<>":"<>consumer_secret)
  end

  def post_auth() do
    headers = [{"Authorization", generate_auth()},
      {"Content-Type", "application/x-www-form-urlencoded;charset=UTF-8"}]
    body = "grant_type=client_credentials"
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]

    {:ok, response} = HTTPoison.post(@auth_url, body, headers,options)
    decode_auth_token(response.body)
  end

  def decode_auth_token(body) do
    body
    |> Poison.decode!
    |> Map.take(@token_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  ########################## TWEET SEARCH ###################################

  def get_tweet(search_term) do
    IO.inspect get_tweets(search_term, 1)
  end

  def get_tweets(search_term, count) do
    token_json = post_auth()
    token = token_json[:access_token]
    url = "https://api.twitter.com/1.1/search/tweets.json?q=#{URI.encode(search_term)}&count=#{count}"
    headers = ["Authorization": "Bearer #{token}", "Accept": "Application/json; Charset=utf-8"]
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]
    {:ok, response} = HTTPoison.get(url, headers, options)
    decode_tweets(response.body)
  end

  def decode_tweets(body) do
    body
    |> Poison.decode!
    |> map_tweets
    # |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  def map_tweets(tweets) do
    tweets
    |> Map.take(["statuses"])
    |> Map.get("statuses")
    |> Enum.map(fn tweet -> Map.take(tweet, @tweet_fields) end)
    # |> Map.take(["created_at"])
    # |> Map.take(["text", "User"])
    # |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
