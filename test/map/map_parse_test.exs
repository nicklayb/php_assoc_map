defmodule Map.ParseTest do
  use ExUnit.Case
  doctest PhpAssocMap

  @source Mock.map_source

  test "parse unflatten array" do
    assert PhpAssocMap.to_map(Mock.spaced_source) == @source
  end

  test "parses associative array to map" do
    assert PhpAssocMap.to_map(Mock.flatten_source) == @source
  end
end
