defmodule PhpAssocMapTest do
  use ExUnit.Case
  doctest PhpAssocMap
  doctest PhpAssocMap.Utils

  @tuple_source Mock.tuple_source()

  describe "tuples" do
    test "serialize tuple exploded array" do
      assert PhpAssocMap.from_tuple(@tuple_source, {:spaces, 2}) == Mock.spaced_source()
    end

    test "serialize tuple exploded array with tabs" do
      assert PhpAssocMap.from_tuple(@tuple_source, :tabs) == Mock.tabbed_source()
    end

    test "serialize tuple to flat array" do
      assert PhpAssocMap.from_tuple(@tuple_source) == Mock.flatten_source()
    end

    test "parses a file as tuple" do
      assert "example.php"
             |> Mock.read_file!()
             |> PhpAssocMap.to_tuple() ==
               @tuple_source
    end

    test "parses tuple complex" do
      assert PhpAssocMap.to_tuple(Mock.complex_source()) == @tuple_source
    end

    test "parses tuple arrayed" do
      assert PhpAssocMap.to_tuple(Mock.arrayed_source()) == @tuple_source
    end

    test "parses tuple commented" do
      assert PhpAssocMap.to_tuple(Mock.commented_source()) == @tuple_source
    end

    test "parses tuple trailing comma" do
      assert PhpAssocMap.to_tuple(Mock.trailing_comma_source()) == @tuple_source
    end

    test "parses tuple unflatten array" do
      assert PhpAssocMap.to_tuple(Mock.spaced_source()) == @tuple_source
    end

    test "parses tuple associative array to tuple" do
      assert PhpAssocMap.to_tuple(Mock.flatten_source()) == @tuple_source
    end
  end

  @map_source Mock.map_source()
  describe "maps" do
    test "serialize map exploded array" do
      assert PhpAssocMap.from_tuple(@map_source, {:spaces, 2}) == Mock.spaced_source()
    end

    test "serialize map exploded array with tabs" do
      assert PhpAssocMap.from_tuple(@map_source, :tabs) == Mock.tabbed_source()
    end

    test "serialize map to flat array" do
      assert PhpAssocMap.from_tuple(@map_source) == Mock.flatten_source()
    end

    test "parses a file as map" do
      assert "example.php"
             |> Mock.read_file!()
             |> PhpAssocMap.to_map() ==
               @map_source
    end

    test "parses map complex" do
      assert PhpAssocMap.to_map(Mock.complex_source()) == @map_source
    end

    test "parses map arrayed" do
      assert PhpAssocMap.to_map(Mock.arrayed_source()) == @map_source
    end

    test "parses map commented" do
      assert PhpAssocMap.to_map(Mock.commented_source()) == @map_source
    end

    test "parses map trailing comma" do
      assert PhpAssocMap.to_map(Mock.trailing_comma_source()) == @map_source
    end

    test "parses map unflatten array" do
      assert PhpAssocMap.to_map(Mock.spaced_source()) == @map_source
    end

    test "parses map associative array to map" do
      assert PhpAssocMap.to_map(Mock.flatten_source()) == @map_source
    end
  end
end
