defmodule PhpAssocMap.Map do
  alias PhpAssocMap.{TypeParser, Utils}

  def to_map(assoc_array), do: to_map(Utils.flatten_assoc(assoc_array), %{})

  def to_map(assoc_array, root) do
    parse_line(root, Utils.split_lines(assoc_array))
  end

  def parse_line(root, lines), do: parse_line(root, lines, 0)

  def parse_line(root, lines, index) when index == length(lines), do: root

  def parse_line(root, lines, index) do
    item = Enum.at(lines, index)
    {left, right} = Utils.split_key_value(item)
    key = TypeParser.parse_key(left)
    parse_line(Map.put(root, key, parse(right)), lines, index + 1)
  end

  def parse(value) do
    case TypeParser.get_type(value) do
      :open_array -> to_map(value)
        _ -> TypeParser.parse(value)
    end
  end
end
