defmodule Pastebin.Users do
  def get_user_key!(params) do
    Pastebin.post(
      "#{Pastebin.Util.get_base_url()}api_login.php",
      {:form, Pastebin.Util.to_param_list(params)}
    )
    |> Pastebin.Util.parse_response()
  end
end
