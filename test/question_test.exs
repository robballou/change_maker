defmodule QuestionTest do
  use ExUnit.Case

  doctest Question

  test "correct?" do
    q = %Question{total: 10, tendered: 15, change_due: 5}
    assert Question.correct?(5, q) == true

    q = %Question{total: 10, tendered: 15, change_due: 0.5}
    assert Question.correct?(0.50, q) == true
  end
end
