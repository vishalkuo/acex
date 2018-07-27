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

  defp get_likelihood(pheromone, node, alpha, beta, current_node, cost_fn) do
    pheromone_impact = :math.pow(pheromone, alpha)
    cost = cost_fn.(current_node, node)
    cost_impact = :math.pow(cost, beta)
    pheromone_impact / cost_impact
  end
end

defmodule C do
  def cf({_x_orig, _y_orig}, {_x, y}) do
    y
  end
end
