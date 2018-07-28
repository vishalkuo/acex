defmodule Pheromones do
  use Agent

  def start_link do
    Agent.start_link(fn -> %{} end)
  end

  def stop(pid) do
    Agent.stop(pid)
  end

  def get_pheromone(pid, pair) do
    Agent.get_and_update(pid, fn m ->
      if Map.has_key?(m, pair) do
        {Map.get(m, pair), m}
      else
        {1, Map.put(m, pair, 1)}
      end
    end)
  end

  def insert(pid, pair, value) do
    Agent.update(pid, &Map.put(&1, pair, value))
  end

  def evaporate(phero_pid, const_pid, all_pairs) do
    rho = Constants.get(const_pid, :rho)
    factor = 1 - rho

    all_pairs
    |> Enum.each(fn pair ->
      current_pheromone = get_pheromone(phero_pid, pair)
      insert(phero_pid, pair, current_pheromone * factor)
    end)
  end

  def density_model(phero_pid, const_pid, pair) do
    q = Constants.get(const_pid, :q)
    pheromone = get_pheromone(phero_pid, pair)
    insert(phero_pid, pair, pheromone + q)
  end

  def quantity_model(phero_pid, const_pid, pair, cost) do
    q = Constants.get(const_pid, :q)
    pheromone = get_pheromone(phero_pid, pair)
    insert(const_pid, pair, pheromone + q / cost)
  end

  def online_delayed(phero_pid, const_pid, pair, l) do
    quantity_model(phero_pid, const_pid, pair, l)
  end
end
