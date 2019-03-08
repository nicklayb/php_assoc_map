defmodule PhpAssocMap.Tuple.Parser do
  def parse([head | tail]), do: [parse(head) | parse(tail)]
  def parse({key, value}), do: {parse(key), parse(value)}
  def parse({:string, _, value}), do: parse(value)
  def parse({_, _, value}), do: parse(value)
  def parse(value) when is_bitstring(value), do: String.replace(value, "\\", "")
  def parse(value), do: value
end
