defmodule SimpleDataStructuresTest do
  use ExUnit.Case
  doctest SimpleDataStructures

  test "greets the world" do
    assert SimpleDataStructures.hello() == :world
  end
end
