defmodule CreditCardValidation.CardTypes.Amex do
  alias CreditCardValidation.CardTypes.CardTypesBehaviour
  @behaviour CardTypesBehaviour

  @impl CardTypesBehaviour
  def begins_with(), do: ["34", "37"]

  @impl CardTypesBehaviour
  def number_length(), do: [15]
end
