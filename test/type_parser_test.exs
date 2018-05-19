defmodule TypeParserTest do
  use ExUnit.Case

  alias PhpAssocMap.TypeParser

  test "parses opening array" do
    assert TypeParser.parse("[...") == :open_array
  end

  test "parses closing array" do
    assert TypeParser.parse("]...") == :close_array
  end

  test "parses a float value" do
    assert TypeParser.parse("43.23") == :float
  end

  test "parses an integer value" do
    assert TypeParser.parse("433") == :integer
  end

  test "parses a single quoted string" do
    assert TypeParser.parse("'A value'") == :string
  end

  test "parses a double quoted string" do
    assert TypeParser.parse("\"A value\"") == :string
  end

  test "parses an association arrow" do
    assert TypeParser.parse("=>") == :arrow
  end

  test "parses a comma" do
    assert TypeParser.parse(",") == :comma
  end

  test "parses a boolean true" do
    assert TypeParser.parse("true") == :bool_true
  end

  test "parses a boolean false" do
    assert TypeParser.parse("false") == :bool_false
  end
end
