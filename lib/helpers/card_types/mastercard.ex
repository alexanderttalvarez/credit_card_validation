defmodule CreditCardValidation.CardTypes.MasterCard do
  alias CreditCardValidation.CardTypes.CardTypesBehaviour
  @behaviour CardTypesBehaviour

  @impl CardTypesBehaviour
  def begins_with(), do: 51..55 |> Enum.map(&Integer.to_string/1)

  @impl CardTypesBehaviour
  def number_length(), do: [16]
end
