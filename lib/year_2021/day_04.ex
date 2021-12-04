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

    players =
      boards
      |> Enum.map(&String.split(&1, " ", trim: true))
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(5)
      |> Enum.chunk_every(5)
      |> Enum.map(fn board -> {board, false, 0, 0} end)
      |> play(numbers_to_draw)

    {_board, _won, _plays, score_1} = first_winner(players)
    {_board, _won, _plays, score_2} = last_winner(players)

    {score_1, score_2}
  end

  defp first_winner(players) do
    players
    |> Enum.sort_by(fn {_, _, plays, _} -> plays end)
    |> Enum.find(fn {_, winner, _, _} -> winner end)
  end

  defp last_winner(players) do
    players
    |> Enum.sort_by(fn {_, _, plays, _} -> plays end, :desc)
    |> Enum.find(fn {_, winner, _, _} -> winner end)
  end

  defp play(players, [current_number | numbers_to_draw]) do
    players
    |> Enum.map(&update_player(&1, current_number))
    |> play(numbers_to_draw)
  end

  defp play(boards, []), do: boards

  defp update_player({board, false, plays, _score}, current_number) do
    board =
      board
      |> List.flatten()
      |> Enum.map(fn
        ^current_number ->
          nil

        number ->
          number
      end)
      |> Enum.chunk_every(5)

    score = calculate_score(board, current_number)
    winner = winner?(board)

    {board, winner, plays + 1, score}
  end

  defp update_player(board, _current_number) do
    board
  end

  defp winner?(board) do
    check_rows_for_winner(board) or board |> rotate() |> check_rows_for_winner()
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

  defp calculate_score(board, current_number) do
    board
    |> List.flatten()
    |> Enum.filter(&!is_nil(&1))
    |> Enum.sum()
    |> Kernel.*(current_number)
  end
end
