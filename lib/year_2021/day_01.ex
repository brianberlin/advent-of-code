defmodule AdventOfCode.Year2021.Day01 do
  @behaviour AdventOfCode

  @doc ~S"""
  Solves Advent of Code 2021 Day 1 Part 1/2

  ## Tests

      iex>input = input(2021, 1)
      iex>assert {answer_1, answer_2} = AdventOfCode.Year2021.Day01.run(input)
      iex>assert is_integer(answer_1)
      iex>assert is_integer(answer_2)
  """
  @impl true
  def run(input) do
    count_greater_measurements = fn depth, {previous_depth, num} ->
      if depth >= previous_depth do
        {depth, num + 1}
      else
        {depth, num}
      end
    end

    answer_1 =
      input
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(&elem(&1, 0))
      |> Enum.reduce({0, 0}, count_greater_measurements)
      |> elem(1)

    answer_2 =
      input
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.map(&Enum.sum/1)
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.reduce(0, fn [a, b], num -> if(b > a, do: num + 1, else: num) end)

    {answer_1, answer_2}
  end
end
