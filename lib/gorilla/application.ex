# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Gorilla.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Gorilla.Repo,
      # Start the Telemetry supervisor
      GorillaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Gorilla.PubSub},
      # Start the Endpoint (http/https)
      GorillaWeb.Endpoint
      # Start a worker by calling: Gorilla.Worker.start_link(arg)
      # {Gorilla.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gorilla.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GorillaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
