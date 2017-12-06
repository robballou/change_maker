defmodule Question do
  defstruct [:total, :tendered, :change_due]

  def amount_tendered(total) do
    dollars = trunc(total)

    # the customer needs to give 1, 5, or 10 more than this value
    modifier = Enum.random([1, 5, 10, 20])

    # figure out the number of modifier bills the user would need
    # cover the total
    times = trunc(dollars / modifier) + 1
    times * modifier
  end

  def new do
    total = random_float()
    tendered = amount_tendered(total)
    change_due = tendered - total
    %Question{total: total, tendered: tendered, change_due: change_due}
  end

  def random_float do
    dollars = Enum.random(0..100)
    cents = Enum.random(0..99) / 100
    dollars + cents
  end

  @spec correct?(number, Question) :: boolean
  def correct?(change, question) do
    Float.round(change, 2) == Float.round(question.change_due, 2)
  end

end
