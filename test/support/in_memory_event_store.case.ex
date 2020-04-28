defmodule BankAPI.InMemoryEventStoreCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Commanded.Assertions.EventAssertions

      import BankAPI.AggregateUtils
    end
  end

  setup do
    on_exit(fn ->
      :ok = Application.stop(:bank_api)
      :ok = Applicaiton.stop(:commanded)

      {:ok, _apps} = Application.ensure_all_started(:bank_api)
    end)
  end
end
