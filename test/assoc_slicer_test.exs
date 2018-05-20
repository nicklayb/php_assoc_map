defmodule AssocSlicerTest do
  use ExUnit.Case

  alias PhpAssocMap.AssocSlicer

  @source "'lvl_1_1'=>['lvl_2_1'=>1,'lvl_2_2'=>'Single quoted string','lvl_2_3'=>\"Double quoted string\"],'lvl_1_2'=>false"
  @nested_source "'lvl_1_1'=>['lvl_2_1'=>1,'lvl_2_2'=>'Single quoted string','lvl_2_3'=>['lvl_3_1'=>'string','lvl_3_1'=>['lvl_4_1'=>false]],'lvl_2_4'=>\"Double quoted string\"],'lvl_1_2'=>false"

  test "split regex" do
    expected = [
      "'lvl_1_1'=>['lvl_2_1'=>1",
      "'lvl_2_2'=>'Single quoted string'",
      "'lvl_2_3'=>\"Double quoted string\"]",
      "'lvl_1_2'=>false"
    ]
    assert AssocSlicer.split(@source) == expected
  end

  test "splits by comma" do
    expected = [
      "'lvl_1_1'=>['lvl_2_1'=>1,'lvl_2_2'=>'Single quoted string','lvl_2_3'=>\"Double quoted string\"]",
      "'lvl_1_2'=>false"
    ]

    assert AssocSlicer.parse(@source) == expected
  end

  test "splits nested by comma" do
    expected = [
      "'lvl_1_1'=>['lvl_2_1'=>1,'lvl_2_2'=>'Single quoted string','lvl_2_3'=>['lvl_3_1'=>'string','lvl_3_1'=>['lvl_4_1'=>false]],'lvl_2_4'=>\"Double quoted string\"]",
      "'lvl_1_2'=>false"
    ]

    assert AssocSlicer.parse(@nested_source) == expected
  end
end
