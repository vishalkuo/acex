defmodule Constants do
  use Agent

  def start_link(
        alpha \\ 0.5,
        beta \\ 1.2,
        rho \\ 0.4,
        q \\ 1000
      ) do
    Agent.start_link(fn ->
      %{
        :alpha => alpha,
        :beta => beta,
        :rho => rho,
        :q => q
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
