defmodule Constants do
  use Agent

  def start_link(
        alpha \\ 0.5,
        beta \\ 1.2,
        rho \\ 0.4,
        q \\ 1000
      ) do
    Agent.start_link(
      fn ->
        %{
          :alpha => alpha,
          :beta => beta,
          :rho => rho,
          :q => q
        }
      end,
      name: __MODULE__
    )
  end

  def get(key) do
    Agent.get(__MODULE__, &Map.get(&1, key))
  end
end
