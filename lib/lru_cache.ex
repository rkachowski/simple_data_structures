defmodule SimpleDataStructures.LRUCache do
  alias __MODULE__

  @enforce_keys [:capacity]
  defstruct lru: [], store: %{}, capacity: 2

  def new(capacity \\ 2) do
    %LRUCache{capacity: capacity}
  end

  def get(cache = %LRUCache{lru: lru, store: store}, key) do
    case Map.get(store, key) do
      nil -> {cache, -1}
      n -> {%LRUCache{cache | lru: update_lru(lru, key)}, n}
    end
  end

  def put(cache = %LRUCache{store: store, lru: lru}, key, value)
      when :erlang.is_map_key(key, store) do
    %LRUCache{cache | store: Map.put(store, key, value), lru: update_lru(lru, key)}
  end

  def put(cache = %LRUCache{capacity: cap, lru: lru}, key, value)
      when length(lru) == cap do
    cache
    |> evict
    |> put(key, value)
  end

  def put(cache = %LRUCache{store: store, lru: lru}, key, value) do
    %LRUCache{cache | store: Map.put(store, key, value), lru: [key | lru]}
  end

  defp update_lru(lru, key) do
    [key | List.delete(lru, key)]
  end

  defp evict(cache = %LRUCache{lru: lru}) when length(lru) == 0, do: cache

  defp evict(cache = %LRUCache{lru: lru, store: store}) do
    to_evict = List.last(lru)

    %LRUCache{
      cache
      | store: Map.delete(store, to_evict),
        lru: List.delete_at(lru, length(lru) - 1)
    }
  end
end
