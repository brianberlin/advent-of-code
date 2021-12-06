defmodule AdventOfCodeTest do
  use ExUnit.Case

  alias AdventOfCode.Year2021

  doctest Year2021.Day01
  doctest Year2021.Day02
  doctest Year2021.Day03
  doctest Year2021.Day04
  doctest Year2021.Day05
  doctest Year2021.Day06

  defp input(year, day) do
    {year, day}
    |> test_data_path()
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  defp test_data_path({year, day}) do
    path = [
      "test/data/#{year}/",
      String.pad_leading("#{day}", 2, "0")
    ]

    Path.join(File.cwd!(), path)
  end
end
