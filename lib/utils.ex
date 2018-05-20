defmodule PhpAssocMap.Utils do
  @key_value_splitter "=>"
  @flatten_regex ~r{\s(?=([^"^']*["'][^"^']*["'])*[^"^']*$)}
  @clean_before ~r{[^\[]*}
  @clean_after ~r{;$}

  alias PhpAssocMap.AssocSlicer

  def split_key_value(entry) do
    splitted = String.split(entry, @key_value_splitter, parts: 2)
    {Enum.at(splitted, 0), Enum.at(splitted, 1)}
  end

  def flatten_assoc(assoc_string) do
    Regex.replace(@flatten_regex, assoc_string, "")
  end

  def split_lines(assoc_array) do
    AssocSlicer.parse(unwrap(assoc_array))
  end

  def unwrap(string) do
    String.slice(string, 1, String.length(string) - 2)
  end

  def clean_up(raw) do
    Regex.replace(@clean_after, Regex.replace(@clean_before, raw, "", global: false), "")
  end
end
