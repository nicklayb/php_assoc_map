defmodule PhpAssocMap.Tuple.Serializer do

  alias PhpAssocMap.Utils

  def from_tuple(tuple) do
    Utils.wrap(Enum.join(from_tuple(tuple, []), ","), "[", "]")
  end

  def from_tuple(tuple, list) when length(list) == length(tuple), do: list

  def from_tuple(tuple, list) do
    index = length(list)
    new_list = list ++ [serialize(Enum.at(tuple, index))]
    from_tuple(tuple, new_list)
  end

  defp serialize({key, value}) when is_list(value) do
    Utils.associate(key, from_tuple(value))
  end

  defp serialize({key, value}) when is_binary(value) do
    Utils.associate(key, Utils.wrap(value, "\""))
  end

  defp serialize({key, value}) do
    Utils.associate(key, value)
  end
end
