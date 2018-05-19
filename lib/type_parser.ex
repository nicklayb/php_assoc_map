defmodule PhpAssocMap.TypeParser do
  @integer_regex ~r{^\d+$}
  @float_regex ~r{^[\d|.]+$}
  @opening_array "["
  @closing_array "]"
  @value_seperator ","
  @association_arrow "=>"
  @bool_true "true"
  @bool_false "false"

  alias PhpAssocMap.Utils

  def get_type(original_value) do
    value = String.trim original_value
    cond do
      surrounded_by?(value, "\"") -> :string
      surrounded_by?(value, "'") -> :string
      integer?(value) -> :integer
      float?(value) -> :float
      String.starts_with?(value, @opening_array) -> :open_array
      String.starts_with?(value, @closing_array) -> :close_array
      String.starts_with?(value, @value_seperator) -> :comma
      value == @association_arrow -> :arrow
      value == @bool_true -> :bool_true
      value == @bool_false -> :bool_false
      true -> raise "Unexpected starting token at start of #{value}"
    end
  end

  def parse(value) do
    case get_type(value) do
      :string -> Utils.unwrap(value)
      :integer ->
        {int_val, _} = Integer.parse(value)
        int_val
      :float ->
        {float_val, _} = Float.parse(value)
        float_val
      :bool_false -> false
      :bool_true -> true
        _ -> value
    end
  end

  def parse_key(key) do
    key
    |> sanitize
    |> String.to_atom
  end

  def sanitize(value) do
    case get_type(value) do
      :string -> Utils.unwrap(value)
      _ -> value
    end
  end

  defp integer?(value), do: Regex.match?(@integer_regex, value)

  defp float?(value), do: Regex.match?(@float_regex, value)

  defp surrounded_by?(value, left), do: surrounded_by?(value, left, left)

  defp surrounded_by?(value, left, right) do
    String.starts_with?(value, left) && String.ends_with?(value, right)
  end
end
