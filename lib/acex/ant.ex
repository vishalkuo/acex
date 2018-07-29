defmodule Ant do
  def traverse_all(num_ants, starting_node, all_nodes, cost_fn, phero_pid, const_pid) do
    Enum.map(1..num_ants, fn _i ->
      traverse(0, starting_node, all_nodes, cost_fn, phero_pid, const_pid)
    end)
  end

  def traverse(cost, current, all_nodes, cost_fn, phero_pid, const_pid) do
    case all_nodes do
      a when a == [] ->
        cost

      a ->
        {next, remaining} = traverse_p(current, a, cost_fn, phero_pid, const_pid)
        traverse(cost + cost_fn.(current, next), next, remaining, cost_fn, phero_pid, const_pid)
    end
  end

  defp traverse_p(current, all_nodes, cost_fn, phero_pid, const_pid) do
    next_node = Cost.calc_next_path(current, all_nodes, cost_fn, phero_pid, const_pid)
    remaining_nodes = all_nodes |> Enum.filter(fn elem -> elem != next_node end)
    # CAN BE SWAPPED
    Pheromones.density_model(phero_pid, const_pid, {current, next_node})
    {next_node, remaining_nodes}
  end
end
