defmodule TwitterSearch do
  @moduledoc """
  Documentation for TwitterSearch.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TwitterSearch.hello
      :world

  """
  def start(_type, _args) do
    Plug.Adapters.Cowboy.http(TwitterRouter, [])
  end
end
