defmodule TwitterSearch do

  def start(_type, _args) do
    {_ok, _} = Plug.Adapters.Cowboy.http(TwitterRouter, [])
  end
end
