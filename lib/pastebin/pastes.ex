defmodule Pastebin.Pastes do
  def create!(params) do
    Pastebin.post(
      "#{Pastebin.Util.get_base_url()}api_post.php",
      {:form, Pastebin.Util.to_param_list(Map.put(params, "api_option", "paste"))}
    )
    |> Pastebin.Util.parse_response()
  end

  def get(id) do
    Pastebin.get("#{Pastebin.Util.get_raw_url()}#{id}")
    |> Pastebin.Util.parse_response()
  end
end
