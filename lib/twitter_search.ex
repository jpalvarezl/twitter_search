defmodule TwitterSearch do

  def start(_type, _args) do
    {_ok, _} = Plug.Adapters.Cowboy.http(TwitterRouter, [])
  end

  def search(search_term) when is_bitstring(search_term) and search_term != "" do

  end
end
