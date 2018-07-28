defmodule Cost do
  @spec calc_next_path(any, [any], (any, any -> float), PID, PID) :: any
  def calc_next_path(current_node, all_nodes, cost_fn, phero_pid, const_pid) do
    cost_nodes =
      all_nodes
      |> Enum.map(fn node ->
        pheromone = Pheromones.get_pheromone(phero_pid, {current_node, node})
        get_likelihood(pheromone, node, current_node, cost_fn, const_pid)
      end)

    total_cost = cost_nodes |> Enum.sum()

    all_probs = cost_nodes |> Enum.map(fn elem -> elem / total_cost end)

    get_next_path(all_probs, all_nodes)
  end

  defp get_next_path(all_probs, all_nodes) do
    Enum.zip(all_nodes, all_probs) |> get_next_path_recursive(:rand.uniform())
  end

  defp get_next_path_recursive([head | tail], remaining) do
    {node, weight} = head
    impact = remaining - weight

    case impact do
      i when i <= 0 -> node
      _ -> get_next_path_recursive(tail, impact)
    end
  end

  defp get_likelihood(pheromone, node, current_node, cost_fn, const_pid) do
    alpha = Constants.get(const_pid, :alpha)
    beta = Constants.get(const_pid, :beta)

    pheromone_impact = :math.pow(pheromone, alpha)
    cost = cost_fn.(current_node, node)
    cost_impact = :math.pow(cost, beta)

    pheromone_impact / cost_impact
  end
end
