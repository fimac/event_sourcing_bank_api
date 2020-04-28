defmodule BankAPI.Router do
  use Commanded.Commands.Router

  alias BankAPI.Accounts.Aggregates.Account

  alias BankAPI.Accounts.Commands.{
    CloseAccount,
    OpenAccount,
    DepositIntoAccount,
    WithdrawFromAccount
  }

  middleware(BankAPI.Middleware.ValidateCommand)

  dispatch([OpenAccount, CloseAccount, DepositIntoAccount, WithdrawFromAccount],
    to: Account,
    identity: :account_uuid
  )
end
