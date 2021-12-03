defmodule AdventOfCode.Year2021.Day03 do
  @behaviour AdventOfCode

  @doc """
  Solves Advent of Code 2021 Day 3 Part 1/2

  ## Tests

      iex>input = input(2021, 3)
      iex>assert {answer_1, answer_2} = Year2021.Day03.run(input)
      iex>assert is_integer(answer_1)
      iex>assert is_integer(answer_2)

  """
  @impl true
  def run(input) do
    answer_1 = calculate_answer_1(input)
    {answer_1, 0}
  end

  defp calculate_answer_1(input) do
    input
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(&Enum.map(&1, fn bit -> String.to_integer(bit) end))
    |> Enum.zip_with(&[most_common(&1), least_common(&1)])
    |> Enum.reduce(fn [a, b], [c, d] -> ["#{c}#{a}", "#{d}#{b}"] end)
    |> Enum.map(&elem(Integer.parse(&1, 2), 0))
    |> Enum.product()
  end

  defp most_common(bits) do
    round(Enum.sum(bits) / length(bits))
  end

  defp least_common(bits) do
    if most_common(bits) == 0 do
      1
    else
      0
    end
  end
end
