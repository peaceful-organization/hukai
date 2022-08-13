defmodule Hukai.ExpletiveTest do
  use ExUnit.Case

  test "no words are expletives" do
    config = Expletive.configure(blacklist: Expletive.Blacklist.english())

    for {{locale, kind}, count} <- Application.get_env(:hukai, :corpus_counts) do
      max_index = count - 1
      table = Hukai.Cache.table_name(locale, kind)

      for index <- 0..max_index//1 do
        [{_, word}] = :ets.lookup(table, index)
        refute Expletive.profane?(word, config)
      end
    end
  end
end
