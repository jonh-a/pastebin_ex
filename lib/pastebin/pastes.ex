defmodule Pastebin.Pastes do
  def create_paste(params) do
    Pastebin.post(
      "#{Pastebin.Util.get_base_url()}api_post.php",
      {:form, Pastebin.Util.to_param_list(Map.put(params, "api_option", "paste"))}
    )
    |> Pastebin.Util.parse_response()
  end
end
