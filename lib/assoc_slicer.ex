defmodule PhpAssocMap.AssocSlicer do
  @slice_regex ~r{(?!\B[["][^"]][['][^']]*),(?![^"']*["|']\B)}
  @closing_regex ~r{\]}
  @opening_regex ~r{\[}

  def parse(assoc) do
    parse(split(assoc), 0, "", [])
  end

  def split(assoc) do
    Regex.split(@slice_regex, assoc)
  end

  defp parse(tokens, index, _, output) when index == length(tokens), do: output

  defp parse(tokens, index, line, output) do
    current_token = Enum.at(tokens, index)
    next_line = line <> current_token
    if bracket_count_matches?(next_line) do
      parse(tokens, index + 1, "", output ++ [next_line])
    else
      parse(tokens, index + 1, (next_line <> ","), output)
    end
  end

  defp bracket_count_matches?(line), do: count(line, @opening_regex) == count(line, @closing_regex)

  defp count(line, regex), do: matches_length(Regex.scan(regex, line))

  defp matches_length([]), do: 0

  defp matches_length(matches), do: length(matches)
end
