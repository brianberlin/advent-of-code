defmodule AdventOfCode.Year2021.Day04 do
  @behaviour AdventOfCode

  @doc """
  Solves Advent of Code 2021 Day 4 Part 1/2

  ## Tests

      iex>input = input(2021, 4)
      iex>assert {answer_1, answer_2} = Year2021.Day04.run(input)
      iex>assert is_integer(answer_1)
      iex>assert is_integer(answer_2)

  """
  @impl true
  def run([numbers_to_draw | boards]) do
    numbers_to_draw =
      numbers_to_draw
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    boards =
      boards
      |> Enum.map(&String.split(&1, " ", trim: true))
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)

    answer_1 = play(numbers_to_draw, boards)

    {answer_1, 0}
  end

  defp play([current_number | numbers_to_draw], boards) do
    boards = mark_boards(boards, current_number)
    winner_index = check_for_winners(boards)

    if is_nil(winner_index) do
      play(numbers_to_draw, boards)
    else
      calculate_score(boards, winner_index, current_number)
    end
  end

  defp play([], boards), do: boards

  defp mark_boards(boards, current_number) do
    Enum.map(boards, fn
      ^current_number ->
        nil

      number ->
        number
    end)
  end

  defp check_for_winners(boards) do
    boards
    |> split_boards()
    |> Enum.find_index(fn board ->
      check_rows_for_winner(board) or board |> rotate() |> check_rows_for_winner()
    end)
  end

  defp check_rows_for_winner(rows) do
    Enum.reduce(rows, false, fn
      row, false -> Enum.all?(row, &is_nil/1)
      _row, true -> true
    end)
  end

  defp rotate([[] | _]), do: []

  defp rotate(m) do
    [Enum.map(m, &hd/1) | rotate(Enum.map(m, &tl/1))]
  end

  defp calculate_score(boards, index, current_number) do
    boards
    |> split_boards()
    |> Enum.at(index)
    |> List.flatten()
    |> Enum.filter(&!is_nil(&1))
    |> Enum.sum()
    |> Kernel.*(current_number)
  end

  defp split_boards(boards) do
    boards
    |> Enum.chunk_every(5)
    |> Enum.chunk_every(5)
  end
end
