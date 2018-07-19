# TwitterSearch

Put your twitter API secrets in a file named ".env" in the root folder of the project, exporting both TWITTER_CONSUMER_KEY and TWITTER_CONSUMER_SECRET
```bash
source .env
iex -S mix
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `twitter_search` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:twitter_search, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/twitter_search](https://hexdocs.pm/twitter_search).
