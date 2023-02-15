defmodule JsonParse.LexicalAnalysisTest do
    use ExUnit.Case
    doctest JsonParse.LexicalAnalysis

    test "lex/1 should return a array of tokens" do
        assert JsonParse.LexicalAnalysis.lex("{\"a\" : [1, 2]}")
        assert JsonParse.LexicalAnalysis.lex("{\"a\" : 1, \"b\" : [2]}")
    end
end