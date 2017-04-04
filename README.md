# Tubo

[![Tubo Build Status](https://travis-ci.org/am-kantox/tubo.svg?branch=master)](https://travis-ci.org/am-kantox/tubo)  
**`Tubo`** is a tiny module providing a wrapper functionality for functions
to easy chain those into pipelines.

## Examples

```elixir
iex> "Hello, world!"
...> |> Tubo.pipe(&Regex.replace/3, [~r/l|o/, "★"])
"He★★★, w★r★d!"
```

In the example above, `Regex.replace/3` expects the first param to be a regular
expression and that’s why plain piping won’t work.

```elixir
iex> "Hello, world!"
...> |> Tubo.spawn(&IO.puts(&1), [])
"Hello, world!"
```

Here we spawn a logger, printing out the piped value, while continuing with the
pipeline. More or less similar behaviour might be achieved with `IO.inspect`,
but `Tubo.spawn/4` spawns the execution (it might be handy for e. g. sending
emails,) and `Tubo.bypass/4` is controlled by the settings and might be compiled
to nothing in production. By default the stub is produced for it.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `tubo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:tubo, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/tubo](https://hexdocs.pm/tubo).
