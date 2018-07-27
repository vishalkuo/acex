defmodule Acex do
  @moduledoc """
  Documentation for Acex.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Acex.hello()
      :world

  """
  def hello do
    :world
  end

  def acs(
        nodes,
        cost_fn,
        alpha,
        beta,
        rho,
        q,
        ants \\ 20,
        iter_count \\ 80
      ) do
    start = Enum.take_random(nodes, 1)
    Pheromones.start_link()
    Constants.start_link(alpha, beta, rho, q)

    # Enum.map(1..iter_count, fn i ->
    #   Enum.map(1..ants, fn j -> do

    #   end)
    # end)
  end

  def traverse(current, nodes, pheromones, cost_fn, alpha, beta) do
    next_node = Cost.calc_next_path(current, nodes, pheromones, cost_fn, alpha, beta)
  end
end
