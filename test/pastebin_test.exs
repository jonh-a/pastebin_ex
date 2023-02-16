defmodule PastebinTest do
  use ExUnit.Case
  doctest Pastebin

  test "test empty paste code" do
    assert Pastebin.Pastes.create!(%{}) ==
             {:error, "Bad API request, api_paste_code was empty"}
  end

  test "test successful paste" do
    {status, _url} = Pastebin.Pastes.create!(%{"api_paste_code" => "test"})
    assert status == :ok
  end
end
