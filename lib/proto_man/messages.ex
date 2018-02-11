defmodule ProtoMan.Messages do
  use Protobuf, from: Path.expand("../proto/messages.proto", __DIR__)
end