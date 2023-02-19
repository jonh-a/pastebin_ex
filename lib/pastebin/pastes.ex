defmodule Pastebin.Pastes do
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

  @doc """
  Fetch pastes for a given user. This data is returned in XML format.

  ## Examples
      iex > p = %{"api_user_key" => "redacted"}
      iex > Pastebin.Pastes.get_user_pastes(p)
      {:ok, "No pastes found."}
  """
  def get_user_pastes(params) do
    Pastebin.post(
      "#{Pastebin.Util.get_base_url()}api_post.php",
      {:form, Pastebin.Util.to_param_list(Map.put(params, "api_option", "list"))}
    )
    |> Pastebin.Util.parse_response()
  end

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
