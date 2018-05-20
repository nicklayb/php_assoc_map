defmodule AssocSlicerTest do
  use ExUnit.Case

  alias PhpAssocMap.{AssocSlicer, Utils}

  test "split regex" do
    source = "'lvl_1_1'=>['lvl_2_1'=>1,'lvl_2_2'=>'Single quoted string','lvl_2_3'=>\"Double quoted string\"],'lvl_1_2'=>false"
    expected = [
      "'lvl_1_1'=>['lvl_2_1'=>1",
      "'lvl_2_2'=>'Single quoted string'",
      "'lvl_2_3'=>\"Double quoted string\"]",
      "'lvl_1_2'=>false"
    ]
    assert AssocSlicer.split(source) == expected
  end


  test "splits nested by comma" do
    source = Utils.unwrap(Mock.flatten_source)

    assert AssocSlicer.parse(source) == Mock.splitted_source
  end
end
