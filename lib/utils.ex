defmodule PhpAssocMap.Utils do
  @key_value_splitter "=>"
  @flatten_regex ~r{\s(?=([^"^']*["'][^"^']*["'])*[^"^']*$)}
  @clean_before ~r{[^\[]*}
  @clean_after ~r{;$}
  @break_line "\n"
  @closing_regex ~r{\]}
  @opening_regex ~r{\[}

  alias PhpAssocMap.AssocSlicer

  def split_key_value(entry) do
    splitted = String.split(entry, @key_value_splitter, parts: 2)
    {Enum.at(splitted, 0), Enum.at(splitted, 1)}
  end

  def associate(key, value) do
    "\"#{key}\"#{@key_value_splitter}#{value}"
  end

  def flatten_assoc(assoc_string) do
    Regex.replace(@flatten_regex, assoc_string, "")
  end

  def explode(assoc), do: explode(assoc, {:spaces, 2})

  @splitter "\s"
  def explode(assoc, {:spaces, count}) do
    splitter = String.duplicate(@splitter, count)
    Enum.join(indent_part(break_down(assoc), splitter, 0, 0, []), @break_line) <> "\n"
  end

  @splitter "\t"
  def explode(assoc, {:tabs}) do
    Enum.join(indent_part(break_down(assoc), @splitter, 0, 0, []), @break_line) <> "\n"
  end

  defp indent_part(parts, _, _, _, output) when length(parts) == length(output), do: output
  defp indent_part(parts, splitter, index, level, output) do
    part = Enum.at(parts, index)
    indentor = String.duplicate(splitter, level)
    new_out = output ++ ["#{indentor}#{String.trim(part)}"]
    indent_part(parts, splitter, index + 1, next_level(level, part), new_out)
  end

  defp next_level(level, part) do
    level
    |> increment_level(part)
    |> decrement_level(part)
  end

  defp increment_level(level, part) do
    if Regex.match?(~r{(\[)}, part), do: level + 1, else: level
  end

  defp decrement_level(level, part) do
    if Regex.match?(~r{(\])}, part), do: level - 1, else: level
  end

  def break_down(assoc) do
    assoc
    |> String.replace(~r{(\[)}, "\\1\n")
    |> String.replace(~r{(\])}, "\n\\1")
    |> String.replace(~r{(,)}, "\\1\n")
    |> String.split("\n")
  end

  def split_lines(assoc_array) do
    AssocSlicer.parse(unwrap(assoc_array))
  end

  def unwrap(string) do
    String.slice(string, 1, String.length(string) - 2)
  end

  def wrap(string, left), do: wrap(string, left, left)

  def wrap(string, left, right), do: left <> string <> right

  def clean_up(raw) do
    Regex.replace(@clean_after, Regex.replace(@clean_before, raw, "", global: false), "")
  end

  def indexes_of(string, char) do
    indexes_of(string, char, [], 0)
  end

  def bracket_count_matches?(line), do: count(line, @opening_regex) == count(line, @closing_regex)
  def bracket_difference(line), do: count(line, @opening_regex) - count(line, @closing_regex)

  defp count(line, regex), do: matches_length(Regex.scan(regex, line))

  defp matches_length([]), do: 0

  defp matches_length(matches), do: length(matches)

  defp indexes_of(string, char, list, last_index) do
    substr = String.slice(string, last_index, String.length(string))
    case :binary.match(substr, char) do
      {index, _} ->
        new_index = index + last_index
        indexes_of(string, char, list ++ [new_index], new_index + 1)
      _ -> list
    end
  end

  def insert_at(string, index, insert) do
    left = String.slice(string, 0, index)
    right = String.slice(string, index, String.length(string))
    "#{left}#{insert}#{right}"
  end
end
