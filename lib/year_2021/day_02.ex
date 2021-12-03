defmodule AdventOfCode.Year2021.Day02 do
  @behaviour AdventOfCode

  @doc ~S"""
  Solves Advent of Code 2021 Day 2 Part 1/2

  ## Tests

      iex>input = input(2021, 2)
      iex>assert {answer_1, answer_2} = Year2021.Day02.run(input)
      iex>assert is_integer(answer_1)
      iex>assert is_integer(answer_2)

  """
  @impl true
  def run(input) do
    %{"down" => down, "up" => up, "forward" => forward} =
      input
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(fn [direction, amount] -> [direction, String.to_integer(amount)] end)
      |> Enum.group_by(&Enum.at(&1, 0), &Enum.at(&1, 1))
      |> Enum.map(&{elem(&1, 0), Enum.sum(elem(&1, 1))})
      |> Enum.into(%{})

    depth = down - up

    answer_1 = depth * forward

    answer_2 =
      input
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(fn [direction, amount] ->
        [String.to_atom(direction), String.to_integer(amount)]
      end)
      |> Enum.reduce(%{depth: 0, aim: 0, horizontal: 0}, fn
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
