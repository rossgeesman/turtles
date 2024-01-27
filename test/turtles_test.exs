defmodule TurtlesTest do
  use ExUnit.Case
  alias Turtles.CorpusIngestion
  alias ETS.Set

  setup do
    {:ok, corpus} = Set.new(name: :test_corpus)
    {:ok, test_corpus} = CorpusIngestion.start(corpus)

    {:ok, test_corpus: test_corpus}
  end

  describe "find_corpus_counts/2" do
    test "returns a list of words and counts from corpus and leaves words it can't find alone", %{test_corpus: test_corpus} do
      assert [{"teenage", 2}, "mutant", "ninja", {"turtles", 2}] =
               Turtles.find_corpus_counts(["teenage", "mutant", "ninja", "turtles"], test_corpus)
    end
  end

  describe "apply_manual_syllable_count" do
    test "takes a list with partial counts and applies the SyllableCount rules to the remainder" do
      assert [{"teenage", 2}, {"mutant", 2}, {"ninja", 2}, {"turtles", 2}] =
               Turtles.apply_manual_syllable_count([{"teenage", 2}, "mutant", "ninja", {"turtles", 2}])
    end
  end

  describe "has_turtle_power?/2" do
    test "returns true if the phrase has the right number of syllables", %{test_corpus: test_corpus} do
      assert Turtles.has_turtle_power?(test_corpus, "teenage mutant ninja turtles") == true
      assert Turtles.has_turtle_power?(test_corpus, "Asian Human Rights Commision") == true
      assert Turtles.has_turtle_power?(test_corpus, "Ace Ventura: Pet Detective") == true
      assert Turtles.has_turtle_power?(test_corpus, "San Diego City Council") == true
      assert Turtles.has_turtle_power?(test_corpus, "Single Payer Health Insurance") == true
      assert Turtles.has_turtle_power?(test_corpus, "Spotted Giant Flying Squirrel") == true
      assert Turtles.has_turtle_power?(test_corpus, "Women Science Fiction Authors") == true
      assert Turtles.has_turtle_power?(test_corpus, "Harland David 'Colonel' Sanders") == true
      assert Turtles.has_turtle_power?(test_corpus, "Edgar Allen Poe Museum") == true
      assert Turtles.has_turtle_power?(test_corpus, "Neo Geo Pocket Color") == true
      assert Turtles.has_turtle_power?(test_corpus, "Fowler's Modern English Usage") == true

    end

    test "returns false if the phrase has the wrong number of syllables", %{test_corpus: test_corpus} do
      assert Turtles.has_turtle_power?(test_corpus, "teenage mutant ninja turtles are awesome") == false
    end
  end
end
