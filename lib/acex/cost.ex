defmodule Cost do
  @spec calc_next_path(any, [any], [float], (any, any -> float), float, float) :: any
  def calc_next_path(current_node, all_nodes, pheromones, cost_fn, alpha, beta) do
    cost_nodes =
      pheromones
      |> Enum.zip(all_nodes)
      |> Enum.map(fn {pheromone, node} ->
        get_likelihood(pheromone, node, alpha, beta, current_node, cost_fn)
      end)

    total_cost = cost_nodes |> Enum.sum()

    all_probs = cost_nodes |> Enum.map(fn elem -> elem / total_cost end)

    all_probs
  end

  defp get_likelihood(pheromone, node, alpha, beta, current_node, cost_fn) do
    pheromone_impact = :math.pow(pheromone, alpha)
    cost = cost_fn.(current_node, node)
    cost_impact = :math.pow(cost, beta)
    pheromone_impact / cost_impact
  end
end

defmodule C do
  def cf(_foo, bar) do
    bar
  end
end
