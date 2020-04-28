defmodule BankAPI.Accounts do
  @moduledoc """
  The accounts context
  """

  alias BankAPI.Repo
  alias BankAPI.Router
  alias BankAPI.Accounts.Commands.OpenAccount
  alias BankAPI.Accounts.Projections.Account

  def get_account(uuid), do: Repo.get!(Account, uuid)

  def open_account(%{"initial_balance" => initial_balance}) do
    account_uuid = UUID.uuid4()

    dispatch_result =
      %OpenAccount{
        initial_balance: initial_balance,
        account_uuid: account_uuid
      }
      |> Router.dispatch()

    case dispatch_result do
      :ok ->
        # {:ok, get_account(account_uuid)}
        {:ok,
         %Account{
           current_balance: initial_balance,
           uuid: account_uuid
         }}

      reply ->
        reply
    end
  end

  def open_account(_params), do: {:error, :bad_command}
end
