defmodule AdventOfCode.Year2021.Day06.Lanternfish do
  use GenServer

  def init(state) do
    {:ok, state}
  end

  def handle_info({:next_day, 81}, {_internal_timer, _age} = state) do
    pid = GenServer.whereis(:parent)
    send(pid, :fish_count)
    {:stop, :normal, state}
  end

  def handle_info({:next_day, _day}, state) do
    {:noreply, update_state(state)}
  end

  def terminate(:normal, _state) do
    send(:parent, {:done, self()})
  end

  defp update_state({0, :baby}) do
    {:ok, pid} = GenServer.start(__MODULE__, {8, :baby}, name: :child)
    send(GenServer.whereis(:parent), {:new_fish, pid})
    {6, :adult}
  end

  defp update_state({0, :adult}) do
    {:ok, pid} = GenServer.start(__MODULE__, {8, :baby}, name: :child)
    send(GenServer.whereis(:parent), {:new_fish, pid})
    {6, :adult}
  end

  defp update_state({internal_timer, age}) do
    {internal_timer - 1, age}
  end
end
