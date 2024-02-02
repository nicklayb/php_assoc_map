defmodule Mock do
  def trailing_comma_source do
    "[\n\t'lvl_1_1'=>[\n\t\t'lvl_2_1'=>1,\n\t\t'lvl_2_2'=>'Single, [\\'quoted\\'] string',\n\t\t'lvl_2_3'=>'Double quote string àéê',\n\t\t],\n\t'lvl_1_2'=>false,\n\t'lvl_1_3'=>[\n\t\t'lvl_2_1'=>true,\n\t\t'lvl_2_2'=>54.12,\n\t\t],\n\t]"
  end

  def tabbed_source do
    "[\n\t'lvl_1_1'=>[\n\t\t'lvl_2_1'=>1,\n\t\t'lvl_2_2'=>'Single, [\\'quoted\\'] string',\n\t\t'lvl_2_3'=>'Double quote string àéê'\n\t\t],\n\t'lvl_1_2'=>false,\n\t'lvl_1_3'=>[\n\t\t'lvl_2_1'=>true,\n\t\t'lvl_2_2'=>54.12\n\t\t]\n\t]"
  end

  def spaced_source do
    "[\n\s\s'lvl_1_1'=>[\n\s\s\s\s'lvl_2_1'=>1,\n\s\s\s\s'lvl_2_2'=>'Single, [\\'quoted\\'] string',\n\s\s\s\s'lvl_2_3'=>'Double quote string àéê'\n\s\s\s\s],\n\s\s'lvl_1_2'=>false,\n\s\s'lvl_1_3'=>[\n\s\s\s\s'lvl_2_1'=>true,\n\s\s\s\s'lvl_2_2'=>54.12\n\s\s\s\s]\n\s\s]"
  end

  def flatten_source do
    "['lvl_1_1'=>['lvl_2_1'=>1,'lvl_2_2'=>'Single, [\\'quoted\\'] string','lvl_2_3'=>'Double quote string àéê'],'lvl_1_2'=>false,'lvl_1_3'=>['lvl_2_1'=>true,'lvl_2_2'=>54.12]]"
  end

  def flatten_single_quote_source do
    "['lvl_1_1'=>['lvl_2_1'=>1,'lvl_2_2'=>'Single, [\\'quoted\\'] string','lvl_2_3'=>'Double quote string àéê'],'lvl_1_2'=>false,'lvl_1_3'=>['lvl_2_1'=>true,'lvl_2_2'=>54.12]]"
  end

  def splitted_source do
    [
      "'lvl_1_1'=>['lvl_2_1'=>1,'lvl_2_2'=>'Single, [\\'quoted\\'] string','lvl_2_3'=>'Double quote string àéê']",
      "'lvl_1_2'=>false",
      "'lvl_1_3'=>['lvl_2_1'=>true,'lvl_2_2'=>54.12]"
    ]
  end

  def commented_source do
    "[\n\s\s'lvl_1_1'=>[\n/*\nThis is comment block \n on multi lines \n*/\s\s\s\s'lvl_2_1'=>1,\n\s\s\s\s'lvl_2_2'=>'Single, [\\'quoted\\'] string',\n\s\s\s\s'lvl_2_3'=>'Double quote string àéê'\n\s\s\s\s],\n\s\s'lvl_1_2'=>false,\n\s\s'lvl_1_3'=>[\n\s\s\s\s'lvl_2_1'=>true,\n\s\s\s\s'lvl_2_2'=>54.12\n\s\s\s\s]\n\s\s]"
  end

  def arrayed_source do
    "array(\n\s\s'lvl_1_1'=>array(\n\s\s\s\s'lvl_2_1'=>1,\n\s\s\s\s'lvl_2_2'=>'Single, [\\'quoted\\'] string',\n\s\s\s\s'lvl_2_3'=>'Double quote string àéê'\n\s\s\s\s),\n\s\s'lvl_1_2'=>false,\n\s\s'lvl_1_3'=>array(\n\s\s\s\s'lvl_2_1'=>true,\n\s\s\s\s'lvl_2_2'=>54.12\n\s\s\s\s)\n\s\s)"
  end

  def complex_source do
    "array(\n\s\s'lvl_1_1'=>array(/*\nThis is comment block \n on multi lines \n*/\n\s\s\s\s'lvl_2_1'=>1,\n\s\s\s\s'lvl_2_2'=>'Single, [\\'quoted\\'] string',\n\s\s\s\s'lvl_2_3'=>'Double quote string àéê'\n\s\s\s\s),\n\s\s'lvl_1_2'=>false,\n\s\s'lvl_1_3'=>array(\n\s\s\s\s'lvl_2_1'=>true,\n\s\s\s\s'lvl_2_2'=>54.12\n\s\s\s\s)\n\s\s)"
  end

  def tuple_source do
    [
      {"lvl_1_1", [
          {"lvl_2_1", 1},
          {"lvl_2_2", "Single, ['quoted'] string"},
          {"lvl_2_3", "Double quote string àéê"},
        ]
      },
      {"lvl_1_2", false},
      {"lvl_1_3", [
          {"lvl_2_1", true},
          {"lvl_2_2", 54.12}
        ]
      },
    ]
  end

  def map_source do
    %{
      "lvl_1_1" => %{
        "lvl_2_1" => 1,
        "lvl_2_2" => "Single, ['quoted'] string",
        "lvl_2_3" => "Double quote string àéê"
      },
      "lvl_1_2" => false,
      "lvl_1_3" => %{
        "lvl_2_1" => true,
        "lvl_2_2" => 54.12
      },
    }
  end

  @base_path "./test/support/fixtures/"
  def read_file!(file_path) do
    @base_path
    |> Path.join(file_path)
    |> File.read!()
  end
end
