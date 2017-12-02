defmodule ChangeTest do
  use ExUnit.Case

  doctest Change

  test "get currency value" do
    assert Change.currency_value(:dime) == 0.1
    assert Change.currency_value(:dollar) == 1
  end

  test "get currency" do
    d = Change.currency(:dime)
    assert d[:value] == 0.1
  end

  test "get currency value by input" do
    assert Change.input_value("1") == 1
    assert Change.input_value(".1") == 0.1
    assert Change.input_value(".10") == 0.1
  end

  test "get currency unit by input" do
    assert Change.input_unit("1") == :dollar
    assert Change.input_unit(".25") == :quarter
  end

  test "parse_item" do
    assert Change.parse_item("1x1") |> elem(0) == :dollar
  end

  test "parse input with single item" do
    assert Change.parse("1x1") |> elem(0) == 1
    assert Change.parse("2x1") |> elem(0) == 2
    assert Change.parse("1x.1") |> elem(0) == 0.1
    assert Change.parse("1x.10") |> elem(0) == 0.1
    assert Change.parse("1x0.10") |> elem(0) == 0.1
  end

  test "parse input with multiple items" do
    assert Change.parse("1x1, 1x.25") |> elem(0) == 1.25
    assert Change.parse("1x1, 1x1") |> elem(0) == 2
  end
end
