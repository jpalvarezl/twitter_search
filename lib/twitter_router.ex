defmodule TwitterRouter do
  use Plug.Router

  plug Plug.Static, at: "/", from: :server
  plug :match
  plug :dispatch

  def init(options) do
    # initialize options

    options
  end

  get "/" do
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, "layouts/pages/index.html.eex")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
