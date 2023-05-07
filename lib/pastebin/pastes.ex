defmodule Pastebin.Pastes do
  @moduledoc """
  Create, read, and delete pastes.
  """

  @spec create_paste!(map) :: {:error, any} | {:ok, any}
  @doc """
  Create a new paste.

  ## Examples
      iex > p = %{"api_paste_code" => "test", "api_paste_name" => "test.txt"}
      iex > Pastebin.Pastes.create_paste!(p)
      {:ok, "https://pastebin.com/paste_id"}
  """
  def create_paste!(params) do
    Pastebin.post(
      "#{Pastebin.Util.get_base_url()}api_post.php",
      {:form, Pastebin.Util.to_param_list(Map.put(params, "api_option", "paste"))}
    )
    |> Pastebin.Util.parse_response()
  end

  @spec get_public_paste(String.t()) :: {:error, any} | {:ok, any}
  @doc """
  Fetch a paste by ID

  ## Examples
      iex > Pastebin.Pastes.get_public_paste("paste_id")
      {:ok, "test"}
  """
  def get_public_paste(id) do
    Pastebin.get("#{Pastebin.Util.get_raw_url()}#{id}")
    |> Pastebin.Util.parse_response()
  end

  @spec get_user_pastes(map) :: {:error, any} | {:ok, any}
  @doc """
  Fetch pastes for a given user. This data is returned in XML format.

  ## Examples
      iex > Pastebin.Pastes.get_user_pastes(%{"api_user_key" => "redacted"})
      {:ok,
        %{
          "data" => %{
            "paste" => %{
              "paste_date" => "redacted",
              "paste_expire_date" => "0",
              "paste_format_long" => "None",
              "paste_format_short" => "text",
              "paste_hits" => "1",
              "paste_key" => "redacted",
              "paste_private" => "0",
              "paste_size" => "4",
              "paste_title" => "Untitled",
              "paste_url" => "https://pastebin.com/redacted"
            }
          }
        }}
  """
  def get_user_pastes(params) do
    Pastebin.post(
      "#{Pastebin.Util.get_base_url()}api_post.php",
      {:form, Pastebin.Util.to_param_list(Map.put(params, "api_option", "list"))}
    )
    |> Pastebin.Util.parse_response(true)
  end

  @spec delete_user_paste!(map, any) :: {:error, any} | {:ok, any}
  @doc """
  Deletes a paste from a given user's account.

  ## Examples
      iex > p = %{"api_user_key" => "redacted"}
      iex > Pastebin.Pastes.delete_user_paste!(p, "paste_id")
      {:ok, "Paste Removed"}
  """
  def delete_user_paste!(params, id) do
    Pastebin.post(
      "#{Pastebin.Util.get_base_url()}api_post.php",
      {:form,
       Pastebin.Util.to_param_list(
         Map.merge(params, %{"api_option" => "delete", "api_paste_key" => id})
       )}
    )
    |> Pastebin.Util.parse_response()
  end

  @spec get_user_paste(map, any) :: {:error, any} | {:ok, any}
  @doc """
  Fetch a paste (including private or unlisted pastes) from a user's account.

  ## Examples
      iex > p = %{"api_user_key" => "redacted"}
      iex > Pastebin.Pastes.get_user_paste!(p, "paste_id")
      {:ok, "test"}
  """
  def get_user_paste(params, id) do
    Pastebin.post(
      "#{Pastebin.Util.get_base_url()}api_post.php",
      {:form,
       Pastebin.Util.to_param_list(
         Map.merge(params, %{"api_option" => "show_paste", "api_paste_key" => id})
       )}
    )
    |> Pastebin.Util.parse_response()
  end
end
