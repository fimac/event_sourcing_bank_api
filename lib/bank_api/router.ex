defmodule BankAPI.Router do
  use Commanded.Commands.Router

  alias BankAPI.Accounts.Aggregates.Account

  alias BankAPI.Accounts.Commands.{CloseAccount, OpenAccount}

  middleware(BankAPI.Middleware.ValidateCommand)

  dispatch([OpenAccount, CloseAccount], to: Account, identity: :account_uuid)
end
