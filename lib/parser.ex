defmodule JsonParse.Parser do
  @rightbrace "}"
  @leftbrace "{"

  @rightbracket "]"
  @leftbracket "["

  @comma ","
  @colon ":"

  def parse([token | rest_tokens ]) do
    case token do
      @leftbrace -> parse_object(rest_tokens)
      @leftbracket -> parse_array(rest_tokens)
      _ -> {rest_tokens, token}
    end
  end

  def parse_object(_tokens, _json_object \\ %{})

  def parse_object([@rightbrace | rest_tokens], json_object),
    do: {json_object, rest_tokens}

  def parse_object(tokens, json_object) do
    object_key = hd(tokens)
    tokens = tl(tokens)

    if hd(tokens) != @colon,
      do: raise("Expected colon after key in object")

    {tokens, object_value} = parse(tl(tokens))
    json_object = Map.put(json_object, object_key, object_value)

    cond do
      hd(tokens) == @rightbrace 
        -> {json_object, tl(tokens)}
      hd(tokens) != @comma 
        -> raise("Expected comma after pair in object")
      true 
        -> parse_object(tl(tokens), json_object)
    end
  end

  def parse_array(_tokens, _json_array \\ [])

  def parse_array([@rightbracket | rest_tokens], json_array),
    do: {json_array, rest_tokens}

  def parse_array(tokens, json_array) do
    {tokens, json_item} = parse(tokens)

    cond do
      hd(tokens) == @rightbracket 
        -> {tl(tokens), [json_item | json_array]}
      hd(tokens) != @comma 
        -> raise("Expected comma after object in array")
      true 
        -> parse_array(tl(tokens), [json_item | json_array])
    end
  end

end
