defmodule TwitterApi do

  def get_token() do
    url = "https://api.twitter.com/oauth2/token"
    headers = [Authorization: "", #Base.encode64(consumer_key:consumer_secret)
      "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"]
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]
  end

  def get_twitts do
    token = "some_token_from_another_request"
    url = "https://api.twitter.com/1.1/search/tweets.json"
    headers = ["Authorization": "Bearer #{token}", "Accept": "Application/json; Charset=utf-8"]
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]
    {:ok, response} = HTTPoison.get(url, headers, options)
    IO.inspect response.body
  end
end
