defmodule Turtles.CorpusIngestion do
  alias ETS.Set
  @filepath "priv/wordlists/"

  @spec start(Set.t()) :: {:ok, Set.t()} | {:error, String.t()}
  def start(%Set{} = corpus_set) do
    @filepath
    |> File.ls()
    |> case do
      {:ok, files} -> ingest_all(corpus_set, files)
      {:error, reason} -> IO.puts("Error: #{reason}")
    end
  end

  @spec ingest_all(Set.t(), [String.t()]) :: {:ok, Set.t()} | {:error, String.t()}
  defp ingest_all(corpus_set, files) do
    Enum.map(files, fn filename -> ingest_file(filename, corpus_set) end)
    |> Enum.any?(fn result -> result != :ok end)
    |> case do
      false -> {:ok, corpus_set}
      _ -> {:error, "Not all files were ingested."}
    end
  end

  @spec ingest_file(String.t(), Set.t()) :: :ok
  defp ingest_file(filename, corpus_set) do
    count = syllable_count_from_filename(filename)

    "#{@filepath}#{filename}"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.each(fn word -> Set.put(corpus_set, {word, count}) end)
  end

  @spec syllable_count_from_filename(String.t()) :: integer()
  defp syllable_count_from_filename(filename) do
    filename
    |> String.trim(".txt")
    |> String.last()
    |> String.to_integer()
  end
end
