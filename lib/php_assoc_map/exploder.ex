defmodule PhpAssocMap.Exploder do
  defstruct [:spacing, :level, :splitter, :line_breaker, :indentation_string]
  alias PhpAssocMap.Exploder
  alias PhpAssocMap.Utils
  @break_line "\n"

  @type input :: [tuple()] | map()
  @type spacing :: :tabs | {:spaces, non_neg_integer()} | :none

  @default_spacing {:spaces, 2}
  @doc """
  Indents the whole associative array using either tabs or spaces. Defaults to 2 spaces.

  Use explode/2 to specify identation between:
    - `{:spaces, non_neg_integer()}`: Indents using the amount of provided spaces
    - `:tabs`: Indents using tabs
    - `:none`: Has no indentation nor break lines
  """
  @spec explode(input(), spacing()) :: binary()
  def explode(ast, spacing \\ @default_spacing) do
    spacing
    |> new()
    |> convert(ast)
  end

  defp convert(
         %Exploder{line_breaker: line_breaker, indentation_string: indentation_string} = exploder,
         ast
       )
       when is_list(ast) or is_map(ast) do
    ast
    |> Enum.map(fn {key, value} ->
      converted_value =
        exploder
        |> level_up()
        |> convert(value)

      if is_map(value) or is_list(value) do
        indentation_string <> Utils.associate(key, {:raw, converted_value})
      else
        indentation_string <> Utils.associate(key, converted_value)
      end
    end)
    |> Enum.join(",#{line_breaker}")
    |> Utils.wrap("[#{line_breaker}",  "#{line_breaker}#{indentation_string}]")
  end

  defp convert(%Exploder{}, value), do: value

  defp new(spacing) do
    put_indentation_string(%Exploder{
      spacing: spacing,
      level: 1,
      splitter: build_splitter(spacing),
      line_breaker: line_breaker(spacing)
    })
  end

  @splitter "\s"
  defp build_splitter({:spaces, count}), do: String.duplicate(@splitter, count)

  @splitter "\t"
  defp build_splitter(:tabs), do: @splitter

  defp build_splitter(:none), do: ""

  defp line_breaker(:none), do: ""
  defp line_breaker(_), do: @break_line

  defp level_up(%Exploder{level: level} = exploder),
    do: put_indentation_string(%Exploder{exploder | level: level + 1})

  defp put_indentation_string(%Exploder{} = exploder) do
    %Exploder{exploder | indentation_string: build_indentation_string(exploder)}
  end

  defp build_indentation_string(%Exploder{level: level, splitter: splitter}) do
    String.duplicate(splitter, level)
  end
end
