defmodule CreditCardValidation.Luhn do
  alias CreditCardValidation.Helpers.CleanCardNumber

  @doc """
  Check if a credit card is valid using Luhn algorithm.

  ## Example

    iex> CreditCardValidation.Luhn.is_valid?("4111111111111111")
    true

    iex> CreditCardValidation.Luhn.is_valid?("4111111111111")
    false

    iex> CreditCardValidation.Luhn.is_valid?("4012888888881881")
    true

    iex> CreditCardValidation.Luhn.is_valid?("5105 1051 0510 5106")
    false

    iex> CreditCardValidation.Luhn.is_valid?("4408 0412 3456 7893")
    true

    iex> CreditCardValidation.Luhn.is_valid?("4417 1234 5678 9112")
    false

  """
  def is_valid?(credit_card) when is_bitstring(credit_card), do: is_valid?(credit_card, CleanCardNumber.all_digits?(credit_card))
  def is_valid?(_credit_card), do: false
  def is_valid?(credit_card, true) do
    credit_card
    |> CleanCardNumber.separate_digits()
    |> double_even_digits()
    |> add_digits()
    |> (fn number ->
      case rem(number, 10) do
        0 -> true
        _ -> false
      end
    end).()
  end
  def is_valid?(_credit_card, false), do: false

  # Doubles the even digits from the end of the number, and add them up if over 10
  defp double_even_digits(credit_card),
    do: credit_card
      |> Enum.reverse()
      |> Stream.with_index(1)
      |> Stream.map(fn {digit, index} ->
        case rem(index, 2) do
          0 -> String.to_integer(digit) * 2
          _ -> String.to_integer(digit)
        end
      end)
      |> Enum.reverse()

  # Adds the digits of a number
  defp add_digits(number) when is_list(number),
    do: add_digits(number |> Enum.join(""))
  defp add_digits(number) when is_bitstring(number),
    do: number
      |> CleanCardNumber.separate_digits()
      |> Enum.reduce(0, fn digit, acc -> acc + String.to_integer(digit) end)

end
