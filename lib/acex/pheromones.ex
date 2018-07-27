defmodule Pheromones do
  use Agent

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get_pheromone(pair) do
    Agent.get_and_update(__MODULE__, fn m ->
      if Map.has_key?(m, pair) do
        {Map.get(m, pair), m}
      else
        {1, Map.put(m, pair, 1)}
      end
    end)
  end

  def insert(pair, value) do
    Agent.update(__MODULE__, &Map.put(&1, pair, value))
  end

  def evaporation(all_pairs, rho) do
    factor = 1 - rho
    # pheromones |> Enum.map(fn elem -> elem * factor end)
  end

  def density_model(pair) do
    q = Constants.get(:q)
    pheromone = get_pheromone(pair)
    insert(pair, pheromone + q)
  end

  def quantity_model(pair, cost) do
    q = Constants.get(:q)
    pheromone = get_pheromone(pair)
    insert(pair, pheromone + q / cost)
  end

  def online_delayed(pair, l) do
    q = Constants.get(:q)
    quantity_model(pair, q, l)
  end
end
