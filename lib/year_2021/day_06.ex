defmodule AdventOfCode.Year2021.Day06 do
  @behaviour AdventOfCode

  @doc """
  Solves Advent of Code 2021 Day 6 Part 1/2

  ## Tests

      iex>input = input(2021, 6)
      iex>assert {answer_1, answer_2} = Year2021.Day06.run(input)
      iex>assert is_integer(answer_1)
      iex>assert is_integer(answer_2)

  """
  @impl true
  def run([input]) do
    [answer_1, answer_2] =
      Enum.map([80, 256], fn days ->
        input
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
        |> Enum.frequencies()
        |> Enum.map(fn {internal_timer, count} ->
          update(internal_timer, 0, 1, days) * count
        end)
        |> List.flatten()
        |> Enum.sum()
      end)

    {answer_1, answer_2}
  end

  defp update(_, day, count, days) when day >= days do
    count
  end

  defp update(0, day, count, days) do
    new_day = day + 1
    count = update(8, new_day, count + 1, days)

    update(6, new_day, count, days)
  end

  defp update(internal_timer, day, count, days) do
    update(0, day + internal_timer, count, days)
  end
end
