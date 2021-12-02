%{"down" => down, "up" => up, "forward" => forward} =
File.cwd!()
|> Path.join("2021/02/input.txt")
|> File.read!()
|> String.split("\n", trim: true)
|> Enum.map(&String.split(&1, " "))
|> Enum.map(fn [direction, amount] -> [direction, String.to_integer(amount)] end)
|> Enum.group_by(&Enum.at(&1, 0), &Enum.at(&1, 1))
|> Enum.map(&{elem(&1, 0), Enum.sum(elem(&1, 1))})
|> Enum.into(%{})

depth = down - up
IO.inspect(depth)
IO.inspect(depth * forward)
