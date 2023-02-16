defmodule Pastebin.Util do
  def get_base_url() do
    "https://pastebin.com/api/"
  end

  def to_param_list(map) do
    get_dev_key(map)
    |> case do
      {:ok, key} -> Map.put(map, "api_dev_key", key)
      {:error, _e} -> map
    end
    |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
  end

  def get_dev_key(params) do
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

  def parse_response(resp) do
    case resp do
      {:ok, resp} -> resp
      {:error, _} -> "Error"
    end
  end
end