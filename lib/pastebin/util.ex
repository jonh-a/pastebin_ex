defmodule Pastebin.Util do
  @moduledoc """
  Various utility functions.
  """

  def get_base_url(), do: "https://pastebin.com/api/"

  def get_raw_url(), do: "https://pastebin.com/raw/"

  @spec to_param_list(map) :: list
  @doc """
  Converts map into list. Adds api_dev_key to list if present in args or environment variable is set.

  ## Examples
      iex > Pastebin.Util.to_param_list(%{"key1" => "value1", "key2" => "value2"})
      [key1: "value1", key2: "value2"]
  """
  def to_param_list(map) do
    get_dev_key(map)
    |> case do
      {:ok, key} -> Map.put(map, "api_dev_key", key)
      {:error, _e} -> map
    end
    |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
  end

  # Given a map of parameters, finds api_dev_key if set. If not set, checks if PASTEBIN_DEV_KEY environment variable is set.
  # Returns status and key if found.
  defp get_dev_key(params) do
    params
    |> Map.fetch(:api_dev_key)
    |> case do
      {:ok, key} ->
        {:ok, key}

      _n ->
        System.get_env("PASTEBIN_DEV_KEY")
        |> case do
          nil -> {:error, "No API key found."}
          n -> {:ok, n}
        end
    end
  end

  # Converts XML string to map object.
  defp convert_xml_to_map(xml) do
    ("<data>" <> xml <> "</data>")
    |> XmlToMap.naive_map()
  end

  @spec parse_response({:error, HTTPoison.Error.t()} | {:ok, HTTPoison.Response.t()}, any) ::
          {:error, any} | {:ok, any}

  @doc """
  Parses HTTPoison response and returns status and body. Converts XML to a map if required.
  """
  def parse_response(resp, xml \\ false) do
    case resp do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case xml do
          true -> {:ok, convert_xml_to_map(body)}
          false -> {:ok, body}
        end

      {:ok, %HTTPoison.Response{body: body}} ->
        {:error, body}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
