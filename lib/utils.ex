defmodule PhpAssocMap.Utils do
  @key_value_splitter "=>"
  @comment_regex ~r{\/\*[\s\S]*?\*\/|([^:]|^)\/\/.*$}
  alias PhpAssocMap.AssocSlicer

  def split_key_value(entry) do
    splitted = String.split(entry, @key_value_splitter, parts: 2)
    {Enum.at(splitted, 0), Enum.at(splitted, 1)}
  end

  def associate(key, value) do
    "'#{key}'#{@key_value_splitter}#{value}"
  end

  def flatten_assoc(assoc_string) do
    assoc_string
    |> remove_comments()
    |> convert_arrays()
    |> String.replace(not_in_quotes("\n"), "")
    |> String.replace(not_in_quotes("\s"), "")
  end

  def remove_comments(assoc) do
    assoc
    |> String.replace(@comment_regex, "")
  end

  def not_in_quotes(char) do
    ~r{(?!\B'[^']*)(#{char})(?![^']*'\B)}
  end

  def split_lines(assoc_array) do
    AssocSlicer.parse(unwrap(assoc_array))
  end

  def unwrap(string) do
    String.slice(string, 1, String.length(string) - 2)
  end

  def wrap(string, left), do: wrap(string, left, left)

  def wrap(string, left, right), do: left <> string <> right

  @clean_before ~r{[^\[]*}
  @clean_after ~r{;$}
  def clean_up(raw) do
    raw
    |> String.replace(@clean_before, "", global: false)
    |> String.replace(@clean_after, "")
  end

  @start_named_array_regex "array\\("
  @end_named_array_regex "\\)"
  def convert_arrays(assoc) do
    assoc
    |> String.replace(not_in_quotes(@start_named_array_regex), "[")
    |> String.replace(not_in_quotes(@end_named_array_regex), "]")
  end

  def bracket_count_matches?(line), do: count(line, not_in_quotes("\\[")) == count(line, not_in_quotes("\\]"))

  defp count(line, regex), do: matches_length(Regex.scan(regex, line))

  defp matches_length([]), do: 0

  defp matches_length(matches), do: length(matches)
end
