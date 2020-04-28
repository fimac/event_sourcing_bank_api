defmodule BankAPI.ProjectorCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias BankAPI.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import BankAPI.DataCase

      import BankAPI.ProjectorUtils
    end
  end

  setup _tags do
    :ok = BankAPI.ProjectorUtils.truncate_database()

    :ok
  end
end
