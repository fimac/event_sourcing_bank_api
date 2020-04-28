defmodule BankAPI.Accounts.Supervisor do
  use Supervisor

  alias BankAPI.Accounts

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_arg) do
    children = [
      worker(Accounts.Projectors.AccountOpened, [], id: :account_opened),
      worker(Accounts.Projectors.AccountClosed, [], id: :account_closed),
      worker(Projectors.DepositsAndWithdrawals, [], id: :deposits_and_withdrawals)
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
