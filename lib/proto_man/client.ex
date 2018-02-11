defmodule ProtoMan.Client do
  require Logger
  alias ProtoMan.{Androids, Messages}
  HTTPoison.start
  def get() do
    Logger.info fn -> "Calling for Android list" end
    res = HTTPoison.get! "http://localhost:4001/androids"
    IO.inspect(res.body)
    Logger.info fn -> "Android response code: #{res.status_code}" end
    Androids.Android.decode(res.body)
  end

  def post(name, special_weapon, version) do
    post(name, special_weapon, version, nil)
  end

  def post(name, special_weapon, version, hp) do
    with {:ok, proto_buf_bytes} <- encode(name, special_weapon, version, hp),
    {:ok, response} <- HTTPoison.post("http://localhost:4001/androids", proto_buf_bytes) do
      Messages.Message.decode(response.body)
    else
      {:error, error} ->
        error
    end
  end

  defp encode(name, special_weapon, version, hp) when is_nil(hp) do
    try do
      protobuf_bytes =
        Androids.Android.new(name: name, special_weapon: special_weapon, version: version)
        |> Androids.Android.encode
      {:ok, protobuf_bytes}
    rescue
      ErlangError ->
        {:error, "Error encoding data"}
    end
  end

  defp encode(name, special_weapon, version, hp) do
    try do
      protobuf_bytes =
      Androids.Android.new(name: name, special_weapon: special_weapon, version: version, hp: %Androids.Android.Health{value: hp})
        |> Androids.Android.encode
      {:ok, protobuf_bytes}
    rescue
      ErlangError ->
        {:error, "Error encoding data"}
    end
  end
end
