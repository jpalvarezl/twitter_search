defmodule TwitterSearch do
  
  def start(_type, _args) do
    {ok, _} = Plug.Adapters.Cowboy.http(TwitterRouter, [])
  end

end
