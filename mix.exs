defmodule ProtoMan.MixProject do
  use Mix.Project

  def project do
    [
      app: :proto_man,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:exprotobuf, :httpoison, :logger],
      mod: {ProtoMan.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.1.2 "},
      {:httpoison, "~> 1.0"},
      {:exprotobuf, "~> 1.2"},
      {:plug, "~> 1.5.0-rc.1"}
    ]
  end
end
