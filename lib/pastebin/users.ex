defmodule Pastebin.Users do
  @doc """
  Generate an api_user_key for authenticated requests.

  ## Examples
      iex > p = %{"api_user_name" => "redacted", "api_user_password" => "redacted"}
      iex > Pastebin.Users.get_user_key!(p)
      {:ok, "redacted"}
  """
  def get_user_key!(params) do
    Pastebin.post(
      "#{Pastebin.Util.get_base_url()}api_login.php",
      {:form, Pastebin.Util.to_param_list(params)}
    )
    |> Pastebin.Util.parse_response()
  end

  @doc """
  Fetch account details for a given user. This data is returned in XML format.

  ## Examples
      iex > p = %{"api_user_key" => "redacted"}
      iex > Pastebin.Users.get_account_settings(p)
      {:ok, "<user>\n\t<user_name>redacted</user_name>\n\t<user_format_short>text</user_format_short>\n\t<user_expiration>N</user_expiration>\n\t<user_avatar_url>@themes/img/guest.png</user_avatar_url>\n\t<user_private>0</user_private>\n\t<user_website></user_website>\n\t<user_email>redacted<user_email>\n\t<user_location></user_location>\n\t<user_account_type>0</user_account_type>\n</user>"}
  """
  def get_account_settings(params) do
    Pastebin.post(
      "#{Pastebin.Util.get_base_url()}api_post.php",
      {:form, Pastebin.Util.to_param_list(Map.put(params, "api_option", "userdetails"))}
    )
    |> Pastebin.Util.parse_response()
  end
end
