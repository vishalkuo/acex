defmodule C do
  def cf({_x_orig, _y_orig}, {_x, y}) do
    y
  end
end

defmodule AntTest do
  use ExUnit.Case

  setup do
    {:ok, ppid} = Pheromones.start_link()

    {:ok, cpid} =
      Constants.start_link(
        1,
        1,
        0.5,
        5
      )

    cost_fn = &C.cf/2
    %{ppid: ppid, cpid: cpid, cost_fn: cost_fn}
  end

  # TODO: more testing
  test "traverses", %{ppid: ppid, cpid: cpid, cost_fn: cost_fn} do
    res = Ant.traverse([], {0, 0}, [{0, 5}, {1, 1}, {1, 2}], cost_fn, ppid, cpid)
    assert [{1, 1}, {0, 5}, {1, 2}] == res
    assert 6 == Pheromones.get_pheromone(ppid, {{0, 0}, {1, 1}})
    assert 1 == Pheromones.get_pheromone(ppid, {{0, 0}, {0, 5}})
    assert 6 == Pheromones.get_pheromone(ppid, {{1, 1}, {0, 5}})
    assert 1 == Pheromones.get_pheromone(ppid, {{1, 1}, {1, 2}})
    assert 6 == Pheromones.get_pheromone(ppid, {{1, 2}, {0, 5}})
  end

  test "traverse multiple", %{ppid: ppid, cpid: cpid, cost_fn: cost_fn} do
    Ant.traverse_all(2, {0, 0}, [{0, 5}, {1, 1}, {1, 2}], cost_fn, ppid, cpid)
    assert 11 == Pheromones.get_pheromone(ppid, {{1, 2}, {0, 0}})
    assert 11 == Pheromones.get_pheromone(ppid, {{1, 1}, {1, 2}})
    assert 11 == Pheromones.get_pheromone(ppid, {{1, 1}, {0, 5}})
    assert 1 == Pheromones.get_pheromone(ppid, {{0, 0}, {0, 5}})
    assert 1 == Pheromones.get_pheromone(ppid, {{1, 2}, {0, 5}})
  end
end
