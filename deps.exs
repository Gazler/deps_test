{:ok, cwd} = File.cwd()
deps = Mix.Dep.Umbrella.loaded()

check_deps = fn ->
  new_deps = Mix.Dep.Umbrella.loaded()
  if deps == new_deps do
    IO.puts """
    #{IO.ANSI.green()}Deps match#{IO.ANSI.reset()}
    """
  else
    IO.puts """
    #{IO.ANSI.red()}Deps diverge#{IO.ANSI.reset()}
    before #{deps |> Enum.map(&(&1.from)) |> inspect}
    after: #{new_deps |> Enum.map(&(&1.from)) |> inspect}
    """
  end
end

IO.puts "Running with local File.cd"
File.cd("/tmp")
check_deps.()

IO.puts "Running afer cd back to initial directory"
File.cd(cwd)
check_deps.()

parent = self()

IO.puts "Running with async task"

Task.Supervisor.async_nolink(Bar.TaskSupervisor, fn ->
  File.mkdir_p("/tmp/broken_deps")
  File.cd("/tmp/broken_deps")
  send(parent, :done)
end)

receive do
  :done -> :ok
end

check_deps.()
