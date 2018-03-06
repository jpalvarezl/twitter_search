defmodule TweetService do

  def get_tweet(search_term) do
    get_tweets(search_term, 1)
  end

  def get_tweets(search_term, count) do
    url = "https://api.twitter.com/1.1/search/tweets.json?q=#{URI.encode(search_term)}&count=#{count}"
    filter_fields(TwitterAdapter.get(url))
  end

  defp filter_fields(tweets) do
    tweets
    |> Map.get("statuses")
    |> Enum.map(&format_tweet(&1))
  end

  defp format_tweet(tweet) do
    %{
      text: tweet["text"],
      created_at: tweet["created_at"],
      user: %{
        name: tweet["user"]["name"],
        profile_image_url: tweet["user"]["profile_image_url"]
      }
    }
  end
end
