defmodule ProtoManTest do
  use ExUnit.Case
  doctest ProtoMan

  test "greets the world" do
    assert ProtoMan.hello() == :world
  end
end
