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
    file = EEx.eval_file "layouts/pages/index.html.eex"
    conn
    |> put_resp_content_type("text/html")
    |> resp(200, file)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
