defmodule PhpAssocMap do
  @flatten_regex ~r{\s(?=([^"^']*["'][^"^']*["'])*[^"^']*$)}

  @record_splitter ~r{,(?![^\(\[]*[\]\)])}

  @key_value_splitter "=>"

  alias PhpAssocMap.TypeParser

  def flatten_assoc(assoc_string) do
    Regex.replace(@flatten_regex, assoc_string, "")
  end

  def to_map(assoc_array), do: to_map(assoc_array, %{})

  def to_map(assoc_array, root) do
    parse_line(root, split_lines(assoc_array))
  end


  def parse_line(root, lines), do: parse_line(root, lines, 0)

  def parse_line(root, lines, index) when index == length(lines), do: root

  def parse_line(root, lines, index) do
    item = Enum.at(lines, index)
    {left, right} = split_key_value(item)
    parse_line(Map.put(root, parse_key(left), parse(right)), lines, index + 1)
  end

  def parse_key(key) do
    key
    |> sanitize
    |> String.to_atom
  end

  def parse(value) do
    case TypeParser.parse(value) do
      :open_array -> to_map(value)
      :string -> unwrap(value)
      :integer ->
        {int_val, _} = Integer.parse(value)
        int_val
      :float -> Float.parse(value)
      :bool_false -> false
      :bool_true -> true
        _ -> value
    end
  end

  def sanitize(value) do
    case TypeParser.parse(value) do
      :string -> unwrap(value)
      _ -> value
    end
  end

  def split_key_value(entry) do
    splitted = String.split(entry, @key_value_splitter, parts: 2)
    {Enum.at(splitted, 0), Enum.at(splitted, 1)}
  end

  def split_lines(assoc_array) do
    Regex.split(@record_splitter, unwrap(assoc_array))
  end

  def unwrap(string) do
    String.slice(string, 1, String.length(string) - 2)
  end
end
