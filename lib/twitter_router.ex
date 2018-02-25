defmodule TwitterRouter do

  @search_result_count 50

  use Plug.Router
  require EEx

  plug :match
  plug Plug.Parsers, parsers: [:urlencoded]
  plug :dispatch

  get "/" do
    with conn <- put_resp_content_type(conn, "text/html"),
         body <- EEx.eval_file("layouts/pages/index.html.eex",[search_term: "", tweets: []])
    do
      resp(conn, 200, body)
    end
  end

  post "/search" do
    search_term = conn.params["search_term"]
    tweets = TwitterApi.get_tweets(search_term, @search_result_count)

    with conn <- put_resp_content_type(conn, "text/html"),
         body <- EEx.eval_file("layouts/pages/index.html.eex",[search_term: search_term, tweets: tweets])
    do
      resp(conn, 200, body)
    end
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
