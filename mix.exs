defmodule Dlex.MixProject do
  use Mix.Project

  def project do
    [
      app: :dlex,
      version: "0.5.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      aliases: [
        "test.all": ["test.http", "test"],
        "test.http": &test_http/1
      ],
      preferred_cli_env: ["test.all": :test, "test.http": :test]
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
      {:db_connection, "~> 2.6"},
      {:grpc, "~> 0.7"},
      {:protobuf, "~> 0.11"},
      {:jason, "~> 1.4.1", optional: true},
      {:mint, "~> 1.5.2", optional: true},
      {:castore, "~> 1.0.5", optional: true},
      {:ecto, "~> 3.11.2", optional: true},
      {:earmark, "~> 1.4", only: :dev},
      {:exrun, "~> 0.2.1", only: :dev},
      {:ex_doc, "~> 0.31.2", only: :dev},
    ]
  end

  defp description do
    "Dlex is a gRPC based client for the Dgraph database."
  end

  defp package do
    [
      maintainers: ["Dmitry Russ(Aleksandrov)", "Eric Hagman"],
      licenses: ["Apache 2.0"],
      links: %{"Github" => "https://github.com/liveforeverx/dlex"}
    ]
  end

  defp test_http(args) do
    env_run([{"DLEX_ADAPTER", "http"}], args)
  end

  defp env_run(envs, args) do
    args = if IO.ANSI.enabled?(), do: ["--color" | args], else: ["--no-color" | args]

    env_line = envs |> Enum.map(fn {key, value} -> "#{key}=#{value}" end) |> Enum.join(" ")
    IO.puts("==> Running tests with environments: #{env_line} mix test")

    {_, res} = System.cmd("mix", ["test" | args], into: IO.binstream(:stdio, :line), env: envs)

    if res > 0 do
      System.at_exit(fn _ -> exit({:shutdown, 1}) end)
    end
  end
end
