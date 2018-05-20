defmodule PhpAssocMap.AssocSlicer do
  alias PhpAssocMap.Utils

  @slice_regex ~r{(?!\B[["][^"]][['][^']]*),(?![^"']*["|']\B)}

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
    if Utils.bracket_count_matches?(next_line) do
      parse(tokens, index + 1, "", output ++ [next_line])
    else
      parse(tokens, index + 1, (next_line <> ","), output)
    end
  end
end
