defmodule Turtles do
  @moduledoc """
    Turtles module identifies a phrase that can be sung to the Teenage Mutant Ninja Turtles theme song.
  """
  alias ETS.Set
  alias Turtles.SyllableCount

  @spec has_turtle_power?(Set.t(), String.t()) :: boolean()
  def has_turtle_power?(corpus, phrase) do
    count_all_syllables(corpus, phrase) == 8
  end

  defp count_all_syllables(corpus, phrase) do
    phrase
    |> String.downcase()
    |> String.split(" ")
    |> Enum.map(fn word -> String.replace(word, ~r/[^a-zA-Z]/, "") end)
    |> find_corpus_counts(corpus)
    |> apply_manual_syllable_count()
    |> Enum.reduce(0, fn {_, count}, acc -> acc + count end)
  end

  @spec find_corpus_counts(List.t(), Set.t()) :: List.t()
  def find_corpus_counts(words, corpus) do
    words
    |> Enum.map(fn word ->
      Set.get!(corpus, word)
      |> case do
        {word, count} -> {word, count}
        nil -> word
      end
    end)
  end

  def apply_manual_syllable_count(words) do
    words
    |> Enum.map(fn word ->
      word
      |> case do
        {word, count} -> {word, count}
        word -> SyllableCount.count(word)
      end
    end)
  end
end
