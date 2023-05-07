defmodule Pastebin.Users do
  @moduledoc """
  Authenticate and view user account settings.
  """

  @spec get_user_key!(map) :: {:error, any} | {:ok, any}
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

  @spec get_account_settings(map) :: {:error, any} | {:ok, any}
  @doc """
  Fetch account details for a given user. This data is returned in XML format.

  ## Examples
      iex > Pastebin.Users.get_account_settings(%{"api_user_key" => "redacted"})
      {:ok,
        %{
          "data" => %{
            "user" => %{
              "user_account_type" => "0",
              "user_avatar_url" => "redacted",
              "user_email" => "redacted",
              "user_expiration" => "N",
              "user_format_short" => "text",
              "user_location" => nil,
              "user_name" => "redacted",
              "user_private" => "0",
              "user_website" => nil
            }
          }
        }}
  """
  def get_account_settings(params) do
    Pastebin.post(
      "#{Pastebin.Util.get_base_url()}api_post.php",
      {:form, Pastebin.Util.to_param_list(Map.put(params, "api_option", "userdetails"))}
    )
    |> Pastebin.Util.parse_response(true)
  end
end
