defmodule JsonParse.ParserTest do
  use ExUnit.Case
  doctest JsonParse.Parser

  test "parse/1 should return a object of array" do
    assert JsonParse.Parser.parse(["{","a",":","[","1",",","2","]","}"]) == {%{"a" => ["2", "1"]}, []}
    assert JsonParse.Parser.parse(["{", "a", ":","1", "," , "b", ":", "[","2","]","}"]) == {%{"a" => "1", "b" => ["2"]}, []}
  end
end
