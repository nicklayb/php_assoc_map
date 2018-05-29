defmodule Tuple.SerializeTest do
  use ExUnit.Case
  doctest PhpAssocMap

  alias PhpAssocMap.{Exploder}

  @source Mock.tuple_source

  test "serialize exploded array" do
    assoc = PhpAssocMap.from_tuple(@source)

    assert Exploder.explode(assoc) == Mock.spaced_source
  end

  test "serialize exploded array with tabs" do
    assoc = PhpAssocMap.from_tuple(@source)

    assert Exploder.explode(assoc, {:tabs}) == Mock.tabbed_source
  end

  test "serialize to flat array" do

    assert PhpAssocMap.from_tuple(@source) == Mock.flatten_source
  end
end
