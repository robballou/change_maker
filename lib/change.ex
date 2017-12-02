defmodule Change do
  @currency %{
    :penny => %{:value => 0.01, :input => ["0.01", ".01"]},
    :nickel => %{:value => 0.05, :input => ["0.05", ".05"]},
    :dime => %{:value => 0.1, :input => ["0.1", ".1", "0.10", ".10"]},
    :quarter => %{:value => 0.25, :input => ["0.25", ".25"]},
    :dollar => %{:value => 1, :input => ["1"]},
    :five => %{:value => 5, :input => ["5"]},
    :ten => %{:value => 10, :input => ["10"]},
    :twenty => %{:value => 20, :input => ["20"]},
  }

  def currency(unit) do
    Map.fetch!(@currency, unit)
  end

  def currency_value(unit) do
    currency(unit) |> Map.get(:value)
  end

  def input_currency(input) do
    Enum.filter(@currency, fn {_, v} -> Enum.member?(v[:input], input) end)
      |> List.first()
  end

  def input_unit(input) do
    input_currency(input) |> elem(0)
  end

  @doc "Get the currency value based on the input value"
  def input_value(input) do
    input_currency(input)
      |> elem(1)
      |> Map.get(:value)
  end

  def parse(input) do
    parsed = String.split(input, ",")
    total = Enum.map(parsed, &Change.parse_item/1)
      |> Enum.reduce(0, fn(item, acc) -> acc + (currency_value(elem(item, 0)) * elem(item, 1)) end)
    {total, false}
  end

  @doc """
  Parse an indiviual answer item.

  A user will answer with "NxU" where N is the number of that currency and U is the
  unit of that currency.
  """
  def parse_item(item) do
    parsed_item = Regex.run(~r{(\d+)\s*x\s*(\d*\.?\d+)}, item)
    times = String.to_integer(Enum.at(parsed_item, 1))
    unit = input_unit(Enum.at(parsed_item, 2))
    # IO.puts :io_lib.format "Times: ~B, Unit: ~w", [times, unit]
    {unit, times}
  end

  def total(change) do
    change_total = Enum.reduce(Map.to_list(change), 0, fn item -> Change.unit_amount(item[0]) * item[1] end)
    change_total
  end

  def unit_amount(unit) do
    case unit do
    :twenty -> 20
    :ten -> 10
    :dollar -> 1
    :quarter -> 0.25
    :dime -> 0.1
    :nickel -> 0.05
    :penny -> 0.01
    end
  end
end

