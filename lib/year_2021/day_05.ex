defmodule AdventOfCode.Year2021.Day05 do
  @behaviour AdventOfCode

  @doc """
  Solves Advent of Code 2021 Day 5 Part 1/2

  ## Tests

      iex>input = input(2021, 5)
      iex>assert {answer_1, answer_2} = Year2021.Day05.run(input)
      iex>assert is_integer(answer_1)
      iex>assert is_integer(answer_2)

  """
  @impl true
  def run(input) do
    data = Enum.map(input, &parse_input/1)
    filtered_data = Enum.filter(data, &horizontal_and_vertical_lines/1)

    max_x =
      data
      |> Enum.flat_map(fn [x1, _, x2, _] -> [x1, x2] end)
      |> Enum.max()

    max_y =
      data
      |> Enum.flat_map(fn [_, y1, _, y2] -> [y1, y2] end)
      |> Enum.max()

    board =
      Enum.map(0..max_y, fn _ ->
        Enum.map(0..max_x, fn _ -> 0 end)
      end)

    answer_1 =
      filtered_data
      |> Enum.reduce(board, &update_board/2)
      |> count()

    answer_2 =
      data
      |> Enum.reduce(board, &update_board/2)
      |> count()

    {answer_1, answer_2}
  end

  defp count(board) do
    board
    |> List.flatten()
    |> Enum.filter(& &1 >= 2)
    |> Enum.count()
  end

  defp parse_input(input) do
    ~r/,| -> /
    |> Regex.split(input)
    |> Enum.map(&String.to_integer/1)
  end

  defp horizontal_and_vertical_lines([x, _, x, _]), do: true
  defp horizontal_and_vertical_lines([_, y, _, y]), do: true
  defp horizontal_and_vertical_lines(_), do: false

  defp set(board, row, col) do
    row_vals = Enum.at(board, row)
    new_row = List.update_at(row_vals, col, & &1 + 1)
    List.replace_at(board, row, new_row)
  end

  defp update_board([x1, y, x2, y], board) do
    Enum.reduce(x1..x2, board, fn num, board ->
      set(board, y, num)
    end)
  end

  defp update_board([x, y1, x, y2], board) do
    Enum.reduce(y1..y2, board, fn num, board ->
      set(board, num, x)
    end)
  end

  defp update_board([x1, y1, x2, y2], board) do
    points = Enum.zip(x1..x2, y1..y2)
    Enum.reduce(points, board, fn {x, y}, board ->
      set(board, y, x)
    end)
  end
end
