defmodule PhpAssocMap do

  def to_map(assoc_array), do: PhpAssocMap.Map.to_map(assoc_array)

  def to_tuple(assoc_array), do: PhpAssocMap.Tuple.to_tuple(assoc_array)
end
