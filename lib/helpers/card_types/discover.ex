defmodule CreditCardValidation.CardTypes.Discover do
  alias CreditCardValidation.CardTypes.CardTypesBehaviour
  @behaviour CardTypesBehaviour

  @impl CardTypesBehaviour
  def begins_with(), do: ["6011"]

  @impl CardTypesBehaviour
  def number_length(), do: [16]
end
