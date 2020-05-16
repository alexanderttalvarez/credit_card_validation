defmodule CreditCardValidation.CLI do
  def main(_args) do
    CreditCardValidation.start_link()
    IO.puts("\nIntroduce a list of credit cards, each one in a new line (press enter after writing it):\n")
    IO.puts("  Warning! write \"exit\" to proceed to evaluate when you are ready\n")
    receive_command()
  end

  defp receive_command() do
    IO.gets("\n> ")
    |> clean_input()
    |> run_command()
  end

  defp run_command("") do
    IO.puts "\nPlease, provide a credit card number"
    receive_command()
  end
  defp run_command("exit") do
    IO.puts "\n\nCredit cards evaluation:\n"
    CreditCardValidation.get_validations()
    |> prepare_output()
  end
  defp run_command(credit_card) do
    CreditCardValidation.validate_credit_card(credit_card)
    receive_command()
  end

  defp clean_input(input),
    do: input
      |> String.trim
      |> String.downcase
      |> String.replace(" ", "")

  def prepare_output([]), do: IO.puts "No credit cards were provided."
  def prepare_output(validations) do
    Enum.map(validations, fn {credit_card, {_, type}, is_valid} ->
      valid = case is_valid do
        true -> "(valid)"
        false -> "(invalid)"
      end
      IO.puts "#{type |> String.upcase}: #{credit_card}\t#{valid}"
    end)
  end

end
