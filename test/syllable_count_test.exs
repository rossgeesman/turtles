defmodule SyllableCountTest do
  use ExUnit.Case
  alias Turtles.SyllableCount

  test "count/1" do
    assert {"teenage", 2} == SyllableCount.count("teenage")
    assert {"mutant", 2} == SyllableCount.count("mutant")
    assert {"ninja", 2} == SyllableCount.count("ninja")
    assert {"turtles", 2} == SyllableCount.count("turtles")
    assert {"dune", 1} == SyllableCount.count("dune")
  end
end
