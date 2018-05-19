defmodule UtilsTest do
  use ExUnit.Case

  alias PhpAssocMap.Utils

  @flatten_source "['lvl_1_1'=>['lvl_2_1'=>1,'lvl_2_2'=>'Single quoted string','lvl_2_3'=>\"Double quoted string\"],'lvl_1_2'=>false]"

  test "flatten associative array" do
    source = """
    [
      'lvl_1_1' => [
        'lvl_2_1' => 1,
        'lvl_2_2' => 'Single quoted string',
        'lvl_2_3' => "Double quoted string"
      ],
      'lvl_1_2' => false
    ]
    """

    assert @flatten_source == PhpAssocMap.Utils.flatten_assoc(source)
  end

  test "extract bracket content" do
    original = "[Unwrapped]"
    expected = "Unwrapped"
    assert Utils.unwrap(original) == expected
  end

  test "flatten a flatten associative array" do
    assert @flatten_source == PhpAssocMap.Utils.flatten_assoc(@flatten_source)
  end

  test "splits by comma" do
    expected = [
      "'lvl_1_1'=>['lvl_2_1'=>1,'lvl_2_2'=>'Single quoted string','lvl_2_3'=>\"Double quoted string\"]",
      "'lvl_1_2'=>false"
    ]

    assert PhpAssocMap.Utils.split_lines(@flatten_source) == expected
  end

  test "splits entry by first key value" do
    value = "'lvl_1_2'=>['nested'=>'things']"
    expected = {"'lvl_1_2'", "['nested'=>'things']"}

    assert PhpAssocMap.Utils.split_key_value(value) == expected
  end

end
