defmodule TwitterAdapter do

  def get(url) do
    headers = ["Authorization": "Bearer #{AuthService.get_bearer_token}", "Accept": "Application/json; Charset=utf-8"]
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]
    {:ok, response} = HTTPoison.get(url, headers, options)
    decode(response.body)
  end

  defp decode(body) do
    body
    |> Poison.decode!
  end
end
