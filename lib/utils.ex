defmodule PhpAssocMap.Utils do
  @type raw_value :: binary() | boolean() | integer() | float() | nil
  @doc """
    Converts a key and a value into an associative array association using arrow

    ## Exemples

        iex> PhpAssocMap.Utils.associate("my_key", "'Some value'")
        "'my_key'=>'Some value'"
  """
  @key_value_splitter "=>"
  @spec associate(raw_value(), raw_value()) :: binary()
  def associate(key, value), do: stringify(key) <> @key_value_splitter <> stringify(value)

  @doc """
    Convert a string for a literal string by escaping quotes and wrapping into them

    ## Exemples

        iex> PhpAssocMap.Utils.stringify("Jon's")
        "'Jon\\\\'s'"

        iex> PhpAssocMap.Utils.stringify(true)
        "true"

        iex> PhpAssocMap.Utils.stringify(24)
        "24"

        iex> PhpAssocMap.Utils.stringify(24.10)
        "24.10"

        iex> PhpAssocMap.Utils.stringify(nil)
        "null"
  """
  @spec stringify(raw_value()) :: binary()
  def stringify(string) when is_binary(string) do
    string
    |> String.replace("'", "\\'")
    |> wrap("'")
  end

  @php_null "null"
  def stringify(nil), do: @php_null

  def stringify(other), do: to_string(other)

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
  def wrap(string, left), do: wrap(string, left, left)

  @spec wrap(binary(), binary(), binary()) :: binary()
  def wrap(string, left, right), do: left <> string <> right
end
