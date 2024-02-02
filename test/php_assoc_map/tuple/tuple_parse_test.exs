defmodule Tuple.ParseTest do
  use ExUnit.Case
  doctest PhpAssocMap

  @source Mock.tuple_source

  test "parses trailing comma" do
    assert PhpAssocMap.to_tuple(Mock.trailing_comma_source) == @source
  end

  test "parse unflatten array" do
    assert PhpAssocMap.to_tuple(Mock.spaced_source) == @source
  end

  test "parses associative array to tuple" do
    assert PhpAssocMap.to_tuple(Mock.flatten_source) == @source
  end
end
