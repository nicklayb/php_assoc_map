defmodule UtilsTest do
  use ExUnit.Case

  alias PhpAssocMap.Utils

  test "flatten associative array" do
    assert Mock.flatten_source == Utils.flatten_assoc(Mock.spaced_source)
  end

  test "extract bracket content" do
    original = "[Unwrapped]"
    expected = "Unwrapped"
    assert Utils.unwrap(original) == expected
  end

  test "flatten a flatten associative array" do
    assert Mock.flatten_source == Utils.flatten_assoc(Mock.flatten_source)
  end

  test "splits by comma" do
    assert Utils.split_lines(Mock.flatten_source) == Mock.splitted_source
  end

  test "splits entry by first key value" do
    value = "'lvl_1_2'=>['nested'=>'things']"
    expected = {"'lvl_1_2'", "['nested'=>'things']"}

    assert Utils.split_key_value(value) == expected
  end

  test "clean up php file" do
    source = "<?php\n\nreturn #{Mock.spaced_source}"

    assert Utils.clean_up(source) == Mock.spaced_source
  end

  test "get indexes of a char" do
    source = "[aa[bb[cc]dd]ee[ff]]"
    expected = [0, 3, 6, 15]

    assert Utils.indexes_of(source, "[") == expected
  end

  test "inserts at" do
    source = "The following  is missing"
    expected = "The following part is missing"

    assert Utils.insert_at(source, 14, "part") == expected
  end
end
