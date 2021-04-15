defmodule SimpleDataStructuresTest.LRUCache do
  use ExUnit.Case

  alias SimpleDataStructures.LRUCache

  test "constructs" do
    cache = LRUCache.new(2)
    assert cache
  end

  test "simply stores and retrieves value" do
    {cache, result} =
      LRUCache.new(2)
      |> LRUCache.put(:test_key, :test_value)
      |> LRUCache.get(:test_key)

    assert result == :test_value
  end

  test "evicts lru upon capacity" do
    cache =
      LRUCache.new(2)
      |> LRUCache.put(:test_key, :test_value)
      |> LRUCache.put(:test_key2, :test_value2)
      # move :test_key
      |> LRUCache.get(:test_key)
      |> elem(0)
      |> LRUCache.put(:test_key3, :test_value3)

    refute Map.has_key?(cache.store, :test_key2)
    assert {_, :test_value} = LRUCache.get(cache, :test_key)
    assert {_, -1} = LRUCache.get(cache, :test_key2)
    assert {_, :test_value3} = LRUCache.get(cache, :test_key3)
  end
end
