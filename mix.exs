defmodule PhpAssocMap.MixProject do
  use Mix.Project

  @version "3.0.0"

  def project do
    [
      app: :php_assoc_map,
      version: @version,
      name: "PhpAssocMap",
      description: "Library that parses PHP's associative array into Elixir's map.",
      source_url: "https://github.com/nicklayb/php_assoc_map",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test]
    ]
  end

  defp package do
    [
      maintainers: ["Nicolas Boisvert"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/nicklayb/php_assoc_map"}
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(environment) when environment in ~w(dev test)a, do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ex_doc, "~> 0.30.9", only: :dev, runtime: false},
      {:credo, "~> 1.7.1", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:mix_test_watch, "~> 0.6", only: :dev, runtime: false}
    ]
  end
end
