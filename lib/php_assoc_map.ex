defmodule PhpAssocMap do

  def to_map(assoc_array), do: PhpAssocMap.Map.Parser.to_map(assoc_array)

  def from_map(map), do: PhpAssocMap.Map.Serializer.from_map(map)

  def to_tuple(assoc_array), do: PhpAssocMap.Tuple.Parser.to_tuple(assoc_array)

  def from_tuple(tuple), do: PhpAssocMap.Tuple.Serializer.from_tuple(tuple)
end
