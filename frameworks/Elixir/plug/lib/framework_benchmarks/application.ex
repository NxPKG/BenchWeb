defmodule BenchWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: BenchWeb.Registry},
      BenchWeb.Repo,
      BenchWeb.CachedWorld,
      {Plug.Cowboy,
       scheme: :http,
       plug: BenchWeb.Endpoints,
       options: [
         port: 8080,
         protocol_options: [
           max_keepalive: 32768
         ],
         transport_options: [
           max_connections: :infinity,
           num_acceptors: 32768
         ]
       ]}
    ]

    opts = [strategy: :one_for_one, name: BenchWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
