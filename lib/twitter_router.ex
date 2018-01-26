defmodule TwitterRouter do
  use Plug.Router
  require EEx

  plug Plug.Static, at: "/", from: :server
  plug :match
  plug :dispatch

  def init(options) do
    # initialize options

    options
  end

  get "/" do
    with conn <- put_resp_content_type(conn, "text/html"),
         body <- EEx.eval_file "layouts/pages/index.html.eex"
    do
      resp(conn, 200, body)
    end
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
