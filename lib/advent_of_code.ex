defmodule AdventOfCode do
  @typep answer :: integer() | binary()
  @callback run([binary()]) :: {part_1 :: answer(), part_2 :: answer()}
end
