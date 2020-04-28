defmodule BankAPI.Accounts do
  @moduledoc """
  The accounts context
  """

  alias BankAPI.Repo
  alias BankAPI.Router

  alias BankAPI.Accounts.Commands.{
    CloseAccount,
    OpenAccount,
    DepositIntoAccount,
    WithdrawFromAccount
  }

  alias BankAPI.Accounts.Projections.Account

  def get_account(id) do
    case Repo.get(Account, id) do
      %Account{} = account ->
        {:ok, account}

      _reply ->
        {:error, :not_found}
    end
  end

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
        {:ok,
         %Account{
           current_balance: initial_balance,
           uuid: account_uuid,
           status: Account.status().open
         }}

      reply ->
        reply
    end
  end

  def open_account(_params), do: {:error, :bad_command}

  def close_account(id) do
    %CloseAccount{
      account_uuid: id
    }
    |> Router.dispatch()
  end

  def deposit(id, amount) do
    dispatch_result =
      %DepositIntoAccount{
        account_uuid: id,
        deposit_amount: amount
      }
      |> Router.dispatch(consistency: :strong)

    case dispatch_result do
      :ok ->
        {
          :ok,
          Repo.get!(Account, id)
        }

      reply ->
        reply
    end
  end

  def withdraw(id, amount) do
    dispatch_result =
      %WithdrawFromAccount{
        account_uuid: id,
        withdraw_amount: amount
      }
      |> Router.dispatch(consistency: :strong)

    case dispatch_result do
      :ok ->
        {
          :ok,
          Repo.get!(Account, id)
        }

      reply ->
        reply
    end
  end

  def uuid_regex do
    ~r/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
  end
end
