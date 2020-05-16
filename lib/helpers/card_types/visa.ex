defmodule CreditCardValidation.CardTypes.Visa do
  alias CreditCardValidation.CardTypes.CardTypesBehaviour
  @behaviour CardTypesBehaviour

  @impl CardTypesBehaviour
  def begins_with(), do: ["4"]

  @impl CardTypesBehaviour
  def number_length(), do: [13, 16]
end
