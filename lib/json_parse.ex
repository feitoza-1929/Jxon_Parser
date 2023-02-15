defmodule JsonParse do
  import JsonParse.LexicalAnalysis
  import JsonParse.Parser
  
  def start(source) do
    source
    |>lex
    |>parse()
    
  end
end
