defmodule Turtles.SyllableCount do
  def count(word) do
    {word, 0}
    |> vowel_count()
    |> exclude_final_e
    |> exclude_dipthongs()
    |> exclude_tripthongs()
  end

  defp vowel_count({word, _count}) do
    {
      word,
      Regex.scan(~r/[aeiouy]/, word) |> Enum.count()
    }
  end

  defp exclude_dipthongs({word, count}) do
    dipthong_count = Regex.scan(~r/[aeiouy]{2}/, word) |> Enum.count()

    {
      word,
      count - dipthong_count
    }
  end

  defp exclude_tripthongs({word, count}) do
    triphthong_count = Regex.scan(~r/[aeiouy]{3}/, word) |> Enum.count()

    {
      word,
      count - triphthong_count
    }
  end

  defp exclude_final_e({word, count}) do
    if String.ends_with?(word, "e") do
      {word, count - 1}
    else
      {word, count}
    end
  end
end
