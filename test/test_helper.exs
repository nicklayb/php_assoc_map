ExUnit.start()

defmodule Mock do
  def tabbed_source do
    """
    [\n\t"lvl_1_1"=>[\n\t\t"lvl_2_1"=>1,\n\t\t"lvl_2_2"=>"Single quoted string",\n\t\t"lvl_2_3"=>"Double quoted string"\n\t\t],\n\t"lvl_1_2"=>false,\n\t"lvl_1_3"=>[\n\t\t"lvl_2_1"=>true,\n\t\t"lvl_2_2"=>54.12\n\t\t]\n\t]
    """
  end

  def spaced_source do
    """
    [\n\s\s"lvl_1_1"=>[\n\s\s\s\s"lvl_2_1"=>1,\n\s\s\s\s"lvl_2_2"=>"Single quoted string",\n\s\s\s\s"lvl_2_3"=>"Double quoted string"\n\s\s\s\s],\n\s\s"lvl_1_2"=>false,\n\s\s"lvl_1_3"=>[\n\s\s\s\s"lvl_2_1"=>true,\n\s\s\s\s"lvl_2_2"=>54.12\n\s\s\s\s]\n\s\s]
    """
  end

  def flatten_source do
    "[\"lvl_1_1\"=>[\"lvl_2_1\"=>1,\"lvl_2_2\"=>\"Single quoted string\",\"lvl_2_3\"=>\"Double quoted string\"],\"lvl_1_2\"=>false,\"lvl_1_3\"=>[\"lvl_2_1\"=>true,\"lvl_2_2\"=>54.12]]"
  end

  def splitted_source do
    [
      "\"lvl_1_1\"=>[\"lvl_2_1\"=>1,\"lvl_2_2\"=>\"Single quoted string\",\"lvl_2_3\"=>\"Double quoted string\"]",
      "\"lvl_1_2\"=>false",
      "\"lvl_1_3\"=>[\"lvl_2_1\"=>true,\"lvl_2_2\"=>54.12]"
    ]
  end

  def tuple_source do
    [
      {"lvl_1_1", [
          {"lvl_2_1", 1},
          {"lvl_2_2", "Single quoted string"},
          {"lvl_2_3", "Double quoted string"},
        ]
      },
      {"lvl_1_2", false},
      {"lvl_1_3", [
          {"lvl_2_1", true},
          {"lvl_2_2", 54.12},
        ]
      },
    ]
  end

  def map_source do
    %{
      "lvl_1_1" => %{
        "lvl_2_1" => 1,
        "lvl_2_2" => "Single quoted string",
        "lvl_2_3" => "Double quoted string"
      },
      "lvl_1_2" => false,
      "lvl_1_3" => %{
        "lvl_2_1" => true,
        "lvl_2_2" => 54.12
      },
    }
  end
end
