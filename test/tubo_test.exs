defmodule TuboTest do
  use ExUnit.Case
  doctest Tubo

  import ExUnit.CaptureIO

  test "#pipe" do
    assert capture_io(fn ->
      "Hello, world!"
      |> Tubo.pipe(&IO.inspect(&1), [])
    end) == "\"Hello, world!\"\n"
  end

  test "#bypass" do
    assert capture_io(fn ->
      "Hello, world!"
      |> Tubo.bypass(&IO.puts(&1), [])
    end) == "Hello, world!\n"
  end
end
