defmodule PhpAssocMap do

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
  def to_map(string), do: string |> ast() |> PhpAssocMap.Map.Parser.parse()

  @doc """
    Converts a map structure to an associative array string. The string key and value are single quoted

    The returned document will not be formatted yet. Use PhpAssocMap.Exploder.explode/1 or PhpAssocMap.Exploder.explode/2 to have it formatted.

    ## Exmples

        iex> PhpAssocMap.from_map(%{"key" => %{"another_key" => "value"}})
        "['key'=>['another_key'=>'value']]"
  """
  @spec from_map(map()) :: binary()
  def from_map(map), do: PhpAssocMap.Map.Serializer.from_map(map)

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
  def to_tuple(string), do: string |> ast() |> PhpAssocMap.Tuple.Parser.parse()

  @doc """
    Converts a keyword list structure to an associative array string. The string key and value are single quoted

    The returned document will not be formatted yet. Use PhpAssocMap.Exploder.explode/1 or PhpAssocMap.Exploder.explode/2 to have it formatted.

    ## Exmples

        iex> PhpAssocMap.from_tuple([{"key", [{"another_key", "value"}]}])
        "['key'=>['another_key'=>'value']]"
  """
  @spec from_tuple([tuple()]) :: binary()
  def from_tuple(tuple), do: PhpAssocMap.Tuple.Serializer.from_tuple(tuple)

  @doc """
    Gets the document AST from leex and yecc parser. The ast is automatically obtain from to_tuple/1 and to_map/1

    ## Exmples

        iex> PhpAssocMap.ast("['key'=>['another_key'=>'value']]")
        [{{:string, 1, "key"}, [{{:string, 1, "another_key"}, {:string, 1, "value"}}]}]
  """
  @spec ast(charlist() | binary()) :: [tuple()]
  def ast(chars) when is_bitstring(chars), do: chars |> String.to_charlist() |> ast()
  def ast(string) do
    with {:ok, tokens, _} <- :php_lang.string(string),
      {:ok, ast} = :php_parse.parse(tokens) do
      ast
    end
  end
end
