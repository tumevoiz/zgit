defmodule Zgit.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ZgitWeb.Telemetry,
      Zgit.Repo,
      {DNSCluster, query: Application.get_env(:zgit, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Zgit.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Zgit.Finch},
      # Start a worker by calling: Zgit.Worker.start_link(arg)
      # {Zgit.Worker, arg},
      # Start to serve requests, typically the last entry
      ZgitWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Zgit.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ZgitWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
