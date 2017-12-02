require InputLoop

defmodule ChangeMaker do
  defp hello do
    IO.puts """
    Hi! We're going to practice making change. To do this, provide answers to the question like:

    > 1x1, 2x.25

    This means we're giving $1.50 in change!

    To quit, type "exit" or hit ctrl-C twice.
    """

  end

  def start do
    hello()
    InputLoop.loop()
  end
end
