defmodule PhpAssocMap.Tuple.Parser do
  alias PhpAssocMap.{Utils, TypeParser}

  def to_tuple(assoc_array), do: to_tuple(Utils.flatten_assoc(assoc_array), [])

  def to_tuple(assoc_array, list) do
    parse_line(list, Utils.split_lines(assoc_array))
  end

  def parse_line(list, lines), do: parse_line(list, lines, 0)

  def parse_line(list, lines, index) when index == length(lines), do: list

  def parse_line(list, lines, index) do
    item = Enum.at(lines, index)
    {left, right} = Utils.split_key_value(item)
    tuple = {TypeParser.parse_key(left), parse(right)}
    parse_line(list ++ [tuple], lines, index + 1)
  end

  def parse(value) do
    case TypeParser.get_type(value) do
      :open_array -> to_tuple(value)
        _ -> TypeParser.parse(value)
    end
  end
end
