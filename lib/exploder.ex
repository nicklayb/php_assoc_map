defmodule PhpAssocMap.Exploder do
  @break_line "\n"

  @spec explode(binary()) :: binary()
  def explode(assoc), do: explode(assoc, {:spaces, 2})

  @splitter "\s"
  def explode(assoc, {:spaces, count}) do
    splitter = String.duplicate(@splitter, count)
    explode_with(assoc, splitter)
  end

  @splitter "\t"
  def explode(assoc, {:tabs}), do: explode_with(assoc, @splitter)

  defp explode_with(assoc, splitter) do
    assoc
    |> break_down()
    |> indent_part(splitter, 0, 0, [])
    |> Enum.join(@break_line)
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
    if Regex.match?(not_in_quotes("\\["), part), do: level + 1, else: level
  end

  defp decrement_level(level, part) do
    if Regex.match?(not_in_quotes("\\]"), part), do: level - 1, else: level
  end

  defp break_down(assoc) do
    assoc
    |> String.replace(not_in_quotes("\\["), "\\1\n")
    |> String.replace(not_in_quotes("\\]"), "\n\\1")
    |> String.replace(not_in_quotes(","), "\\1\n")
    |> String.split("\n")
  end

  defp not_in_quotes(char), do: ~r{(?!\B'[^']*)(#{char})(?![^']*'\B)}
end
