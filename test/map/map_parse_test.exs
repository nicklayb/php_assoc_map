defmodule Map.ParseTest do
  use ExUnit.Case
  doctest PhpAssocMap

  @source Mock.map_source

  test "parses trailing comma" do
    assert PhpAssocMap.to_map(Mock.trailing_comma_source) == @source
  end

  test "parse unflatten array" do
    assert PhpAssocMap.to_map(Mock.spaced_source) == @source
  end

  test "parses associative array to map" do
    assert PhpAssocMap.to_map(Mock.flatten_source) == @source
  end

  test "parses with single quotes and serialize back" do
    map = PhpAssocMap.to_map(Mock.flatten_single_quote_source)

    assert Mock.flatten_source == PhpAssocMap.from_map(map)
  end

end
