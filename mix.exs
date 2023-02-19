defmodule Pastebin.MixProject do
  use Mix.Project

  def project do
    [
      app: :pastebin,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:poison, "~> 5.0"},
      {:exjsx, "~> 4.0"},
      {:elixir_xml_to_map, "~> 3.0"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end
end
