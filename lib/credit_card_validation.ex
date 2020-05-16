defmodule CreditCardValidation do
  use GenServer

  alias CreditCardValidation.CardType
  alias CreditCardValidation.Luhn

  @genserver_name :credit_card_validation

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: @genserver_name)
  end

  def init(_) do
    {:ok, []}
  end

  @doc """
  Validates a new credit card, and inserts its data in the GenServer
  """
  def validate_credit_card(credit_card) do
    GenServer.cast(@genserver_name, {:validate_credit_card, credit_card})
  end

  @doc """
  Retrieves the state from the GenServer, containing the result of the validations
  """
  def get_validations() do
    GenServer.call(@genserver_name, {:get_validations})
  end

  def handle_cast({:validate_credit_card, credit_card}, state) do
    {:noreply, state ++ [{credit_card, CardType.get_type(credit_card), Luhn.is_valid?(credit_card)}]}
  end

  def handle_call({:get_validations}, _from, state) do
    {:reply, state, state}
  end
end
