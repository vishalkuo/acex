defmodule Ant do
  def traverse(iterations, path, current, all_nodes, cost_fn) do
    case iterations do
      i when i > 0 -> nil
      _ -> path
    end
  end

  defp traverse(current, all_nodes, pheromones, cost_fn) do
    next_node = Cost.calc_next_path(current, nodes, pheromones, cost_fn, alpha, beta)
    remaining_nodes = all_nodes |> Enum.filter(fn elem -> elem != next_node end)
    # CAN BE TUNED
    Pheromones.density_model({current, next_node}, q)
  end
end
