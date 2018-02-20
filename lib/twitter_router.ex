defmodule TwitterRouter do
  use Plug.Router
  require EEx

  plug :match
  plug :dispatch
  #https://stackoverflow.com/a/34479313/7721253
  #plug Plug.Parsers, parsers: [:urlencoded]

  get "/" do
    with conn <- put_resp_content_type(conn, "text/html"),
         body <- EEx.eval_file "layouts/pages/index.html.eex"
    do
      resp(conn, 200, body)
    end
  end

  post "/search" do
    {:ok, data, conn} = read_body(conn)
    IO.inspect conn
    #send_resp(conn, 200, conn.params["search-term"])
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
