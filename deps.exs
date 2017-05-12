deps = Mix.Dep.Umbrella.loaded()
File.cd("/tmp")
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
