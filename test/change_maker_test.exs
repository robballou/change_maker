defmodule ChangeMakerTest do
  use ExUnit.Case
  doctest ChangeMaker

  test "make change bug" do
    # ? Customer total: 66.76; Amount tendered: 70; Change due: 3.24
    # > 3x1, 2x.1, 4x.01

    q = %Question{total: 66.76, tendered: 70, change_due: 3.24}
    {question, change, correct, err} = InputLoop.parse_input("3x1, 2x.1, 4x.01", q)
    assert change == 3.24
    assert err == false
    assert correct == true
    assert question == nil
  end
end
