defmodule PhpAssocMap.Map.Parser do
  def parse(list) when is_list(list) do
    Enum.reduce(list, %{}, fn ({key, value}, acc) ->
      Map.put(acc, parse(key), parse(value))
    end)
  end
  def parse({:string, _, value}), do: parse(value)
  def parse({_, _, value}), do: parse(value)
  def parse(value) when is_bitstring(value), do: String.replace(value, "\\", "")
  def parse(value), do: value
end
