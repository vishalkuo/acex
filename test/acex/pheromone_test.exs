defmodule PheromoneTest do
  use ExUnit.Case

  setup do
    {:ok, ppid} = Pheromones.start_link()

    {:ok, cpid} =
      Constants.start_link(
        1,
        1,
        0.5,
        5,
        1,
        1
      )

    %{ppid: ppid, cpid: cpid}
  end

  test "get pheromone", %{ppid: ppid} do
    assert 1 == Pheromones.get_pheromone(ppid, {1, 1})
  end

  test "insert pheromones", %{ppid: ppid} do
    pair = {1, 1}
    Pheromones.insert(ppid, pair, 10)
    assert 10 == Pheromones.get_pheromone(ppid, pair)
  end

  test "evaporate", %{ppid: ppid, cpid: cpid} do
    pair = {1, 1}
    Pheromones.insert(ppid, pair, 10)
    Pheromones.evaporate(ppid, cpid)
    assert 5 == Pheromones.get_pheromone(ppid, pair)
  end

  test "density", %{ppid: ppid, cpid: cpid} do
    pair = {1, 1}
    Pheromones.insert(ppid, pair, 10)
    Pheromones.density_model(ppid, cpid, pair)
    assert 15 == Pheromones.get_pheromone(ppid, pair)
  end

  test "quantity", %{ppid: ppid, cpid: cpid} do
    pair = {1, 1}
    Pheromones.insert(ppid, pair, 10)
    Pheromones.quantity_model(ppid, cpid, pair, 5)
    assert 11 == Pheromones.get_pheromone(ppid, pair)
  end

  test "online delayed", %{ppid: ppid, cpid: cpid} do
    pair = {1, 1}
    Pheromones.insert(ppid, pair, 10)
    Pheromones.online_delayed(ppid, cpid, pair, 5)
    assert 11 == Pheromones.get_pheromone(ppid, pair)
  end
end
