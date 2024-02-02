defmodule PhpAssocMap.Exploder do
  alias PhpAssocMap.Utils
  @break_line "\n"

  @type input :: [tuple()] | map()
  @type spacing :: :tabs | {:spaces, non_neg_integer()}

  @default_spacing {:spaces, 2}
  @doc """
    Indents the whole associative array using either tabs or spaces. Defaults to 2 spaces.

    Use explode/2 to specify identation.

    Exemples

        iex> PhpAssocMap.Exploder.explode("['key'=>['next'=>'value']]")
        "[\n  'key'=>[\n    'next'=>'value'\n    ]\n  ]"

        iex> PhpAssocMap.Exploder.explode("['key'=>['next'=>'value']]", {:tabs})
        "[\n\t'key'=>[\n\t\t'next'=>'value'\n\t\t]\n\t]"

        iex> PhpAssocMap.Exploder.explode("['key'=>['next'=>'value']]", {:spaces, 1})
        "[\n 'key'=>[\n  'next'=>'value'\n  ]\n ]"
  """
  @spec explode(input(), spacing()) :: binary()
  def explode(ast, spacing \\ @default_spacing) do
    splitter = build_splitter(spacing)
    Enum.reduce(ast, {[], 1}, fn {key, value}, {acc, level} ->
      row = explode(key, value, level, splitter)
      
    end)
  end

  defp explode(key, value, level, splitter) when is_binary(value) do
    indentor = String.duplicate(level, splitter)
    indentor <> associate(key, value)
  end

  defp explode(key, value, level, splitter) when is_map(value) or is_list(value) do
  end

  @splitter "\s"
  defp build_splitter({:spaces, count}), do: String.duplicate(@splitter, count)

  @splitter "\t"
  defp build_splitter(:tabs), do: @splitter

  defp associate(key, value) do
    key
    |> Utils.wrap("'")
    |> PhpAssocMap.Utils.associate(value)
  end

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
