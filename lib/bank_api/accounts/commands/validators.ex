defmodule BankAPI.Accounts.Commands.Validators do
  def positive_integer(data, min \\ 0) when is_integer(data) do
    case data > min do
      true -> :ok
      _ -> {:error, "Argument must be bigger than #{min}"}
    end
  end

  def ppositive_integer(_, _) do
    {:error, "Argument must be an integer"}
  end
end
