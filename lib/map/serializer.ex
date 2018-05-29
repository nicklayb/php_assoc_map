defmodule PhpAssocMap.Map.Serializer do

  alias PhpAssocMap.{Utils, TypeParser}

  def from_map(map) do
    Utils.wrap(Enum.join(from_map(map, []), ","), "[", "]")
  end

  def from_map(map, list) when length(list) == map_size(map), do: list

  def from_map(map, list) do
    index = length(list)
    new_list = list ++ [serialize(Enum.at(map, index))]
    from_map(map, new_list)
  end

  defp serialize({key, value}) when is_map(value) do
    Utils.associate(key, from_map(value))
  end

  defp serialize({key, value}) when is_binary(value) do
    Utils.associate(key, TypeParser.stringify(value))
  end

  defp serialize({key, value}) do
    Utils.associate(key, value)
  end
end
