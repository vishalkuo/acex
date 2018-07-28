defmodule C do
  def cf({_x_orig, _y_orig}, {_x, y}) do
    y
  end
end

defmodule CostTest do
  use ExUnit.Case

  setup do
    {:ok, ppid} = Pheromones.start_link()

    {:ok, cpid} =
      Constants.start_link(
        1,
        1,
        0.5,
        1000
      )

    %{ppid: ppid, cpid: cpid}
  end

  test "test calc next path", state do
    ppid = state[:ppid]
    cpid = state[:cpid]

    current_node = {0, 0}
    next_nodes = [{0, 1}, {1, 1}, {1, 2}]
    cost_fn = &C.cf/2

    next_path = Cost.calc_next_path(current_node, next_nodes, cost_fn, ppid, cpid)
  end
end