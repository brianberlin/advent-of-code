defmodule AdventOfCode.Year2021.Day02 do
  @behaviour AdventOfCode

  @doc ~S"""
  Solves Advent of Code 2021 Day 2 Part 1/2

  ## Example

      iex>{answer_1, answer_2} = Year2021.Day02.run(input(2021, 1))
      is_integer(answer_1) and is_integer(answer_2)
  """
  @impl true
  def run(input) do
    answer_1 = :implement

    answer_2 =
      input
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(fn [direction, amount] ->
        [String.to_atom(direction), String.to_integer(amount)]
      end)
      |> Enum.scan(%{depth: 0, aim: 0, horizontal: 0}, fn
        [:forward, value], acc ->
          acc
          |> Map.put(:horizontal, acc.horizontal + value)
          |> Map.put(:depth, acc.depth + acc.aim * value)

        [:down, value], acc ->
          Map.put(acc, :aim, acc.aim + value)

        [:up, value], acc ->
          Map.put(acc, :aim, acc.aim - value)
      end)
      |> Map.take([:depth, :horizontal])
      |> Map.values()
      |> Enum.product()

    {answer_1, answer_2}
  end
end
