defmodule Bar.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(Task.Supervisor, [[name: Bar.TaskSupervisor]])
      # Starts a worker by calling: Bar.Worker.start_link(arg1, arg2, arg3)
      # worker(Bar.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bar.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
