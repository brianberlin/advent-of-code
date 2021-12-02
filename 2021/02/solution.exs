File.cwd!()
|> Path.join("2021/02/input.txt")
|> File.read!()
|> String.split("\n", trim: true)
|> Enum.map(&String.split(&1, " "))
|> Enum.map(fn [direction, amount] -> [String.to_atom(direction), String.to_integer(amount)] end)
|> Enum.reduce(%{depth: 0, aim: 0, horizontal: 0}, fn
  [:forward, value], acc ->
    acc
    |> Map.put(:horizontal, acc.horizontal + value)
    |> Map.put(:depth, acc.depth + (acc.aim * value))

  [:down, value], acc ->
    Map.put(acc, :aim, acc.aim + value)

  [:up, value], acc ->
    Map.put(acc, :aim, acc.aim - value)

end)
|> Map.take([:depth, :horizontal])
|> Map.values
|> Enum.product()
|> IO.inspect()
