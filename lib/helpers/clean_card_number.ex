defmodule CreditCardValidation.Helpers.CleanCardNumber do
  @doc """
  Removes the empty spaces
  """
  def clean(credit_card), do: separate_digits(credit_card) |> Enum.join("")

  @doc """
  Split every digit in the credit card and return a clean array
  """
  def separate_digits(credit_card),
    do: credit_card
      |> String.split("")
      |> Enum.reject(&(&1=="" || &1==" "))

  @doc """
  Checks whether the credit card only contains numbers (spaces allowed)
  """
  def all_digits?(credit_card), do: all_digits?(credit_card, :string.to_integer(clean(credit_card)))
  def all_digits?(_credit_card, {_, ""}), do: true
  def all_digits?(_credit_card, {_, _}), do: false
end
