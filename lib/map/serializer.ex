defmodule PhpAssocMap.Map.Serializer do
  alias PhpAssocMap.Utils

  def from_map(map), do: Utils.wrap(Enum.join(from_map(map, []), ","), "[", "]")
  def from_map(map, list) when length(list) == map_size(map), do: list
  def from_map(map, list) do
    index = length(list)
    new_list = list ++ [serialize(Enum.at(map, index))]
    from_map(map, new_list)
  end

  defp serialize({key, value}) when is_map(value), do: Utils.associate(key, from_map(value))
  defp serialize({key, value}) when is_binary(value), do: Utils.associate(key, Utils.stringify(value))
  defp serialize({key, value}), do: Utils.associate(key, value)
end
