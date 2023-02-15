defmodule JsonParse.LexicalAnalysis do
  def lex("" = _source),
    do: []

  def lex(source) do
    source
    |> lex_whitespace()
    |> lex_string()
    |> lex_symbols()
  end

  def lex_whitespace(string) when is_list(string),
    do: string

  def lex_whitespace(string) do
    white_space_regex = ~r(^[\h]+)

    case Regex.match?(white_space_regex, string) do
      true -> lex(Regex.replace(white_space_regex, string, "", global: false))
      _ -> string
    end
  end

  def lex_string(string) when is_list(string),
    do: string

  def lex_string(string) do
    string_regex = ~r(^[\\\"\w\s]+)
    quote_regex = ~r([\\\"\s])

    case Regex.match?(string_regex, string) do
      true ->
        [
          Regex.replace(quote_regex, get_match(string, string_regex), "")
          | lex(Regex.replace(string_regex, string, "", global: false))
        ]

      _ ->
        string
    end
  end

  def lex_symbols(string) when is_list(string),
    do: string

  def lex_symbols(string) do
    symbols_regex = ~r(^[\:\,\[\]\{\}]+)

    case Regex.match?(symbols_regex, string) do
      true ->
        [
          get_match(string, symbols_regex)
          | lex(Regex.replace(symbols_regex, string, "", global: false))
        ]

      _ ->
        string
    end
  end

  def get_match(string, pattern_regex),
    do: "#{List.first(Regex.run(pattern_regex, string, [{:capture, :first}]))}"
end
