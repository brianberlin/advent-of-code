defmodule AdventOfCode.Year2021.Day06 do

  def run(input) do
    input
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies()
    |> Enum.map(fn {internal_timer, count} ->
      update(internal_timer, 0, 1, 256) * count
    end)
    |> List.flatten()
    |> Enum.sum()
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

year = 2021
day = 6
path = [
    "test/data/#{year}/",
    String.pad_leading("#{day}", 2, "0")
]
path = Path.join(File.cwd!(), path)
input = path |> File.read!() |> String.split(",", trim: true)
Day06.run(input)
