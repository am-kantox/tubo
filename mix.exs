defmodule Tubo.Mixfile do
  use Mix.Project

  @app :tubo

  def project do
    [app: @app,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  def application do
    [extra_applications: []]
  end

  defp description do
    """
    **The tiny wrapper for functions to use them in pipelines.**
    """
  end

  defp package do
    [
     name: @app,
     files: ~w|lib mix.exs README.md|,
     maintainers: ["Aleksei Matiushkin"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/am-kantox/tubo",
              "Docs" => "https://hexdocs.pm/tubo"}]
  end

  defp deps do
    [
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:credo, "~> 0.5", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end
end
