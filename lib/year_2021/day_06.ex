defmodule AdventOfCode.Year2021.Day06 do
  @behaviour AdventOfCode
  use GenServer

  alias AdventOfCode.Year2021.Day06.Lanternfish

  @impl true
  def init(input) do
    pids =
      Enum.map(input, fn internal_timer ->
        {:ok, pid} = GenServer.start(Lanternfish, {internal_timer, :adult})
        pid
      end)

    send(self(), :new_day)
    {:ok, {pids, _fish_count = 0, _day = 0}}
  end

  @impl true
  def handle_info(:new_day, {pids, fish_count, day}) do
    day = day + 1
    |> IO.inspect(label: "day")
    for pid <- pids do
      send(pid, {:next_day, day})
    end
    IO.inspect(pids |> length, label: "pids")


    send(self(), :new_day)
    {:noreply, {pids, fish_count, day}}
  end

  def handle_info(:new_day, state) do
    {:noreply, state}
  end

  @impl true
  def handle_info(:fish_count, {pids, fish_count, day}) do
    {:noreply, {pids, fish_count + 1, day}}
  end

  def handle_info({:new_fish, pid}, {pids, fish_count, day}) do
    {:noreply, {pids ++ [pid], fish_count, day}}
  end

  def handle_info({:done, pid}, {pids, fish_count, day}) do
    pids = Enum.filter(pids, &pid !== &1)

    if Enum.empty?(pids) do
      {:stop, :normal, {pids, fish_count, day}}
    else
      {:noreply, {pids, fish_count, day}}
    end
  end

  @impl true
  def terminate(:normal, {_pids, fish_count, _day}) do
    IO.inspect(fish_count)
  end


  @doc """
  Solves Advent of Code 2021 Day 6 Part 1/2

  ## Tests

      iex>input = test_data_path({2021, 6}) |> File.read!() |> String.split(",", trim: true)
      iex>assert {answer_1, answer_2} = Year2021.Day06.run(input)
      iex>assert is_integer(answer_1)
      iex>assert is_integer(answer_2)

  """
  @impl true
  def run(input) do
    input = Enum.map(input, &String.to_integer/1)
    GenServer.start_link(__MODULE__, input, name: :parent)

    Process.sleep(50_000)
    {0, 0}
  end
end
