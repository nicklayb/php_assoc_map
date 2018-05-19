defmodule TypeParserTest do
  use ExUnit.Case

  alias PhpAssocMap.TypeParser

  test "parses opening array" do
    assert TypeParser.get_type("[...") == :open_array
  end

  test "parses closing array" do
    assert TypeParser.get_type("]...") == :close_array
  end

  test "parses a float value" do
    assert TypeParser.get_type("43.23") == :float
  end

  test "parses an integer value" do
    assert TypeParser.get_type("433") == :integer
  end

  test "parses a single quoted string" do
    assert TypeParser.get_type("'A value'") == :string
  end

  test "parses a double quoted string" do
    assert TypeParser.get_type("\"A value\"") == :string
  end

  test "parses an association arrow" do
    assert TypeParser.get_type("=>") == :arrow
  end

  test "parses a comma" do
    assert TypeParser.get_type(",") == :comma
  end

  test "parses a boolean true" do
    assert TypeParser.get_type("true") == :bool_true
  end

  test "parses a boolean false" do
    assert TypeParser.get_type("false") == :bool_false
  end

  test "extract bracket content" do
    original = "[Unwrapped]"
    expected = "Unwrapped"
    assert TypeParser.unwrap(original) == expected
  end
end
