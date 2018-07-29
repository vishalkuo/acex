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
        ants,
        iter_count
      ) do
    {:ok, ppid} = Pheromones.start_link()
    {:ok, cpid} = Constants.start_link(alpha, beta, rho, q, ants, iter_count)

    iterate(nodes, cost_fn, 0, iter_count, 0, ppid, cpid)
  end

  def iterate(nodes, cost_fn, current_count, max_iter, best, ppid, cpid) do
    starting_node = Enum.take_random(nodes, 1)
    remaining_nodes = nodes |> Enum.filter(fn elem -> elem != starting_node end)

    case current_count do
      k when k == max_iter ->
        best

      _ ->
        Ant.traverse_all(
          Constants.get(cpid, :num_ants),
          starting_node,
          remaining_nodes,
          cost_fn,
          ppid,
          cpid
        )

        Pheromones.evaporate(ppid, cpid)
    end
  end
end
