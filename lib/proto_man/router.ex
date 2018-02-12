defmodule ProtoMan.Router do
  use Plug.Router
  alias ProtoMan.{Androids, Messages}
  plug :match
  plug :dispatch

  get "/androids" do
    android = 
      Androids.Android.new(name: "Rock", 
                                    special_weapon: :ProtoShield, 
                                    version: :'V1', 
                                    hp: %Androids.Android.Health{value: 100})
    resp = Androids.Android.encode(android)

    conn
    |> put_resp_header("content-type", "application/octet-stream")
    |> send_resp(200, resp)
  end

  post "/androids" do
    with {:ok, proto_bytes, _conn} <-  Plug.Conn.read_body(conn),
         {:ok, _android} <- Androids.safe_decode(proto_bytes),
         message <- Messages.Message.new(text: "successfully posted", status: :OK),
         resp <- Messages.Message.encode(message)
         do
      conn
      |> put_resp_header("content-type", "application/octet-stream")
      |> send_resp(200, resp)
    else
      {:error, error} ->
        message = Messages.Message.new(text: error, status: :ERROR)
        resp = Messages.Message.encode(message)
        conn
        |> put_resp_header("content-type", "application/octet-stream")
        |> send_resp(500, resp)
    end
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end