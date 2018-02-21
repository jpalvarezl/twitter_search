defmodule TwitterRouter do
  use Plug.Router
  require EEx

  plug :match
  plug Plug.Parsers, parsers: [:urlencoded]
  plug :dispatch
  #https://stackoverflow.com/a/34479313/7721253

  get "/" do
    with conn <- put_resp_content_type(conn, "text/html"),
         body <- EEx.eval_file "layouts/pages/index.html.eex"
    do
      resp(conn, 200, body)
    end
  end

  post "/search" do
    #pass search-term as parameter
    with conn <- put_resp_content_type(conn, "text/html"),
         body <- EEx.eval_file "layouts/pages/index.html.eex"
    do
      send_resp(conn, 200, "Searched for: "<>conn.params["search-term"])
      #resp(conn, 200, body)
    end
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
