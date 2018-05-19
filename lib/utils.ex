defmodule PhpAssocMap.Utils do
  @key_value_splitter "=>"
  @flatten_regex ~r{\s(?=([^"^']*["'][^"^']*["'])*[^"^']*$)}
  @record_splitter ~r{,(?![^\(\[]*[\]\)])}

  def split_key_value(entry) do
    splitted = String.split(entry, @key_value_splitter, parts: 2)
    {Enum.at(splitted, 0), Enum.at(splitted, 1)}
  end

  def flatten_assoc(assoc_string) do
    Regex.replace(@flatten_regex, assoc_string, "")
  end

  def split_lines(assoc_array) do
    Regex.split(@record_splitter, unwrap(assoc_array))
  end

  def unwrap(string) do
    String.slice(string, 1, String.length(string) - 2)
  end
end
