defmodule InputLoop do
  @doc """
  Start the input loop
  """
  def loop(question \\ nil) do
    # get a new question if we don't already have one
    question =
      case question do
        nil -> Question.new()
        _ -> question
      end

    IO.puts :io_lib.format "? Customer total: ~.2f; Amount tendered: ~B; Change due: ~.2f", [question.total, question.tendered, question.change_due]
    input = IO.gets "> "
    IO.puts ""

    # get out of here if the user exists
    unless String.match?(input, ~r/^exit/) do
      {question, change, correct, err} = parse_input(input, question)

      # tell the user about the error
      if err do
        IO.puts :io_lib.format "! Could not parse input: ~s", [input]
      end

      # tell the user they got it incorrect
      unless correct do
        IO.puts :io_lib.format "X Incorrect, try again: ~.2f != ~.2f", [change, question.change_due]
      end

      loop(question)
    end
  end

  def parse_input(input, question) do
    {change, err} = Change.parse(input)

    # answer is correct if there are no errors and the change value is correct
    question_correct = Question.correct? change, question
    # IO.puts :io_lib.format "question_correct= ~w", [question_correct]
    correct = !err and question_correct

    # create a new question if the user got it correct
    question = case correct do
      true -> nil
      false -> question
    end

    {question, change, correct, err}
  end
end
