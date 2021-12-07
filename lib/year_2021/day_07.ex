defmodule AdventOfCode.Year2021.Day07 do
  @behaviour AdventOfCode

  @doc """
  Solves Advent of Code 2021 Day 7 Part 1/2

  ## Tests

      iex>input = input(2021, 7)
      iex>assert {answer_1, answer_2} = Year2021.Day07.run(input)
      iex>assert is_integer(answer_1)
      iex>assert is_integer(answer_2)

  """
  @impl true
  def run([input]) do
    data =
      input
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    range = Enum.max(data)..Enum.min(data)

    answer_1 =
      Enum.reduce(range, nil, fn position, acc ->
        data
        |> Enum.map(&difference(&1, position))
        |> Enum.sum()
        |> min(acc)
      end)


    answer_2 =
      Enum.reduce(range, nil, fn position, acc ->
        data
        |> Enum.map(&Enum.sum(0..difference(&1, position)))
        |> Enum.sum()
        |> min(acc)
      end)

    {answer_1, answer_2}
  end

  defp difference(a, b) when a > b, do: a - b
  defp difference(a, b), do: b - a
end
