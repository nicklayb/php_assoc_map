defmodule PhpAssocMap.Utils do
  @doc """
    Converts a key and a value into an associative array association using arrow

    ## Exemples

        iex> PhpAssocMap.Utils.associate("my_key", "'Some value'")
        "'my_key'=>'Some value'"
  """
  @key_value_splitter "=>"
  @spec associate(binary(), binary()) :: binary()
  def associate(key, value), do: "'#{key}'#{@key_value_splitter}#{value}"

  @doc """
    Convert a string for a literal string by escaping quotes and wrapping into them

    ## Exemples

        iex> PhpAssocMap.Utils.stringify("Jon's")
        "'Jon\\\\'s'"
  """
  @spec stringify(binary()) :: binary()
  def stringify(string) do
    string
    |> String.replace("'", "\\'")
    |> wrap("'")
  end

  @doc """
    Wraps a value inside specified string.

    Using wrap/2 will wrap both end using the same string.
    Using the wrap/3 will wrap left with second parameter and right with third

    ## Exemples

        iex> PhpAssocMap.Utils.wrap("house", "*")
        "*house*"

        iex> PhpAssocMap.Utils.wrap("house", "{", "}")
        "{house}"
  """
  @spec wrap(binary(), binary()) :: binary()
  @spec wrap(binary(), binary(), binary()) :: binary()
  def wrap(string, left), do: wrap(string, left, left)
  def wrap(string, left, right), do: left <> string <> right
end
