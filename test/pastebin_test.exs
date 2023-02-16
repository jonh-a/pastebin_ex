defmodule PastebinTest do
  use ExUnit.Case
  doctest Pastebin

  test "greets the world" do
    assert Pastebin.hello() == :world
  end
end
