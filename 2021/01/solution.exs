count_greater_measurements = fn depth, {previous_depth, num} ->
  if depth > previous_depth do
    {depth, num + 1}
  else
    {depth, num}
  end
end

File.cwd!()
|> Path.join("2021/01/input.txt")
|> File.read!()
|> String.split("\n", trim: true)
|> Enum.map(&String.to_integer/1)
|> Enum.chunk_every(3, 1, :discard)
|> Enum.map(&Enum.sum/1)
|> Enum.reduce({0, 0}, count_greater_measurements)
|> elem(1)
|> Kernel.-(1)
|> IO.inspect()
