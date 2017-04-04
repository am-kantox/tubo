defmodule Tubo do
  @moduledoc """
  `Tubo` is a tiny module providing a wrapper functionality for functions
  to easy chain those into pipelines.
  """

  defmacrop params_valid(fun, args, place) do
    quote do
      is_function(unquote(fun)) and
        is_list(unquote(args)) and
        is_integer(unquote(place))
    end
  end

  @stub_bypass Application.get_env(:tubo, :stub, true)

  @doc """
  The plain helper to pipe everything.

  ## Examples

      iex> "Hello, world!"
      ...> |> Tubo.pipe(&Regex.replace/3, [~r/l|o/, "★"])
      "He★★★, w★r★d!"
  """
  @spec pipe(any, function(), List.t, Integer.t) :: any
  def pipe(value, fun, args, place \\ 1) when params_valid(fun, args, place) do
    apply(fun, List.insert_at(args, place, value))
  end

  @doc """
  The plain helper to spawn anything inside pipeline.

  ## Examples

      iex> "Hello, world!"
      ...> |> Tubo.spawn(&IO.puts(&1), [])
      "Hello, world!"
  """
  @spec spawn(any, function(), List.t, Integer.t) :: any
  def spawn(value, fun, args, place \\ 1) when params_valid(fun, args, place) do
    Kernel.spawn(Tubo, :pipe, [value, fun, args, place])
    value
  end

  @doc """
  The plain helper to execute anything inside pipeline, returning the piped value.

  By default this method is NOT compiled. Set

  ```elixir
  config :tubo, stub: false
  ```

  in `config.exs` to compile it.

  ## Examples

      iex> "Hello, world!"
      ...> |> Tubo.bypass(&IO.puts("¡" <> &1), [])
      "Hello, world!"
      # "¡Hello, world!" is printed asynchronously
  """
  if @stub_bypass do
    @spec bypass(any, function(), List.t, Integer.t) :: any
    def bypass(value, _fun, _args, _place \\ 1), do: value
  else
    @spec bypass(any, function(), List.t, Integer.t) :: any
    def bypass(value, fun, args, place \\ 1) when params_valid(fun, args, place) do
      Tubo.pipe(value, fun, args, place)
      value
    end
  end
end
