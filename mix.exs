defmodule PhpAssocMap.MixProject do
  use Mix.Project

  def project do
    [
      app: :php_assoc_map,
      version: "0.4.2",
      name: "PhpAssocMap",
      description: "Library that parses PHP's associative array into Elixir's map.",
      source_url: "https://github.com/nicklayb/php_assoc_map",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
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

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.8", only: :test},
      {:mix_test_watch, "~> 0.6", only: :dev, runtime: false}
    ]
  end
end
