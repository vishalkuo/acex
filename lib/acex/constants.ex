defmodule Constants do
  use Agent

  def start_link(
        alpha,
        beta,
        rho,
        q,
        num_ants,
        iter_count
      ) do
    Agent.start_link(fn ->
      %{
        :alpha => alpha,
        :beta => beta,
        :rho => rho,
        :q => q,
        :num_ants => num_ants,
        :iter_count => iter_count
      }
    end)
  end

  def get(pid, key) do
    Agent.get(pid, &Map.get(&1, key))
  end

  def stop(pid) do
    Agent.stop(pid)
  end
end
