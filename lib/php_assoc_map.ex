defmodule PhpAssocMap do
  alias PhpAssocMap.Exploder
  @doc """
  Parses an associative array string (or charlist) to a key-valued map. Both single and double quotes are supported.

  *Note*: If the string starts with `<?php return`, it'll be ignored

  ## Exemples

      iex> PhpAssocMap.to_map("['key' => ['another_key' => 'value']]")
      %{"key" => %{"another_key" => "value"}}

      iex> PhpAssocMap.to_map("<?php return ['key' => ['another_key' => 'value']];")
      %{"key" => %{"another_key" => "value"}}
  """
  @spec to_map(binary() | charlist()) :: any()
  def to_map(string) do
    string
    |> to_tuple
    |> convert_to_map()
  end

  defp convert_to_map(list) when is_list(list) do
    Enum.reduce(list, %{}, fn ({key, value}, acc) ->
      Map.put(acc, convert_to_map(key), convert_to_map(value))
    end)
  end
  defp convert_to_map(value) when is_binary(value), do: String.replace(value, "\\", "")
  defp convert_to_map(value), do: value

  @doc """
  Converts a map structure to an associative array string. The string key and value are single quoted

  The returned document will not be formatted yet. Use PhpAssocMap.Exploder.explode/1 or PhpAssocMap.Exploder.explode/2 to have it formatted.

  ## Exmples

      iex> PhpAssocMap.from_map(%{"key" => %{"another_key" => "value"}})
      "['key'=>['another_key'=>'value']]"
  """
  @spec from_map(map(), Exploder.spacing()) :: binary()
  def from_map(map, spacing \\ :none), do: Exploder.explode(map, spacing)

  @doc """
  Parses an associative array string (or charlist) to a key-valued keyword list. Both single and double quotes are supported.

  *Note*: If the string starts with `<?php return`, it'll be ignored

  ## Exemples

      iex> PhpAssocMap.to_tuple("['key' => ['another_key' => 'value']]")
      [{"key", [{"another_key", "value"}]}]

      iex> PhpAssocMap.to_tuple("<?php return ['key' => ['another_key' => 'value']];")
      [{"key", [{"another_key", "value"}]}]
  """
  @spec to_tuple(binary() | charlist()) :: [tuple()]
  def to_tuple(string), do: ast(string)

  @doc """
  Converts a keyword list structure to an associative array string. The string key and value are single quoted

  The returned document will not be formatted yet. Use PhpAssocMap.Exploder.explode/1 or PhpAssocMap.Exploder.explode/2 to have it formatted.

  ## Exmples

      iex> PhpAssocMap.from_tuple([{"key", [{"another_key", "value"}]}])
      "['key'=>['another_key'=>'value']]"
  """
  @spec from_tuple([tuple()], Exploder.spacing()) :: binary()
  def from_tuple(tuple, spacing \\ :none), do: Exploder.explode(tuple, spacing)

  @doc """
  Gets the document AST from leex and yecc parser. The ast is automatically obtain from to_tuple/1 and to_map/1

  ## Exmples

      iex> PhpAssocMap.ast("['key'=>['another_key'=>'value']]")
      [{"key", [{"another_key", "value"}]}]
  """
  @spec ast(charlist() | binary()) :: [tuple()]
  def ast(chars) when is_bitstring(chars), do: chars |> String.to_charlist() |> ast()
  def ast(string) do
    with {:ok, tokens, _} <- :php_lang.string(string),
      {:ok, ast} <- :php_parse.parse(tokens) do
      ast
    end
  end
end
