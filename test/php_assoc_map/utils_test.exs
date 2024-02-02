defmodule UtilsTest do
  use ExUnit.Case
  doctest PhpAssocMap.Utils
  doctest PhpAssocMap

  alias PhpAssocMap.Utils

  test "wraps expression with one value" do
    assert Utils.wrap("test", "\"") == "\"test\""
  end

  test "wraps expression with two values" do
    assert Utils.wrap("test", "[", "]") == "[test]"
  end

  test "stringify expression" do
    assert Utils.stringify("Jon's") == "'Jon\\'s'"
    assert Utils.stringify("L'utilisation de l'application") == "'L\\'utilisation de l\\'application'"
  end

  test "associate key and value" do
    assert Utils.associate("key", "value") == "'key'=>value"
  end

  test "correctly gets the ast" do
    assert PhpAssocMap.ast("['key'=>'value']")
  end
end
