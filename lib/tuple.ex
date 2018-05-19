defmodule PhpAssocMap.Tuple do
  alias PhpAssocMap.{Utils}

  def to_tuple(assoc_array), do: to_tuple(Utils.flatten_assoc(assoc_array), [])

  def to_tuple(assoc_array, list) do

  end
end
