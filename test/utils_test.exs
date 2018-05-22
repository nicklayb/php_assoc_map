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

  test "cleans up a complexe array" do
    assert Utils.flatten_assoc(Mock.complex_source) == Mock.flatten_source
  end

  test "converts named array to brackets" do
    converted = Utils.convert_arrays(Mock.arrayed_source)
    assert Utils.flatten_assoc(converted) == Mock.flatten_source
  end

  test "removes comment from array" do
    assert Utils.remove_comments(Mock.commented_source) == Mock.spaced_source
  end

  test "removes comments and flatten array" do
    uncommented = Utils.remove_comments(Mock.commented_source)
    assert Utils.flatten_assoc(uncommented) == Mock.flatten_source
  end
end
