defmodule CreditCardValidation.CardType do
  alias CreditCardValidation.Helpers.CleanCardNumber
  @types ["Amex", "Visa", "MasterCard", "Discover"]

  @doc ~S"""
  Returns the type the credit card belongs to

  ## Examples

    iex> CreditCardValidation.CardType.get_type("295435345234")
    {:error, "Unknown"}

    iex> CreditCardValidation.CardType.get_type("378282246310005")
    {:ok, "Amex"}

    iex> CreditCardValidation.CardType.get_type("4012888888881881")
    {:ok, "Visa"}

    iex> CreditCardValidation.CardType.get_type("5105105105105100")
    {:ok, "MasterCard"}

    iex> CreditCardValidation.CardType.get_type("6011111111111117")
    {:ok, "Discover"}

  """
  @spec get_type(any, [String.t]) :: {:error, String.t} | {:ok, String.t}
  def get_type(credit_card), do: get_type(CleanCardNumber.clean(credit_card), @types)
  defp get_type(credit_card, [type | types]) do
    with true <- begins_with(credit_card, type),
      true <- number_length(credit_card, type) do
        {:ok, type}
    else
      _ ->  case types do
          [] -> {:error, "Unknown"}
          _ -> get_type(credit_card, types)
        end
    end
  end

  # Returns true if the credit card starts with any of the values set by the card type
  defp begins_with(credit_card, type),
    do: apply(get_card_type_module(type), :begins_with, [])
      |> Enum.any?(&String.starts_with?(credit_card, &1))

  # Returns true if the credit card length is the one set by the card type
  defp number_length(credit_card, type),
    do: apply(get_card_type_module(type), :number_length, [])
    |> Enum.any?(&(String.length(credit_card) == &1))

  defp get_card_type_module(module),
    do: "Elixir.CreditCardValidation.CardTypes.#{module}" |> String.to_atom()
end
