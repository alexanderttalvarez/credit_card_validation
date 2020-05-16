# CreditCardValidation

CreditCardValidation is a command line program, as well as an elixir library, to find out whether a Credit Card is valid, and its type.

So far it only checks among the types: MasterCard, VISA, Discover and AMEX.

## Installation as library for your project

Add `credit_card_validation` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:credit_card_validation, git: "git@github.com:alexanderttalvarez/credit_card_validation.git", tag: "v0.1.0"}}
  ]
end
```

### Usage as library

There are two main functions you can call to evaluate your credit cards:

```elixir
CreditCardValidation.CardType.get_type(credit_card) # it will tell you the type of credit card
CreditCardValidation.Luhn.is_valid?(credit_card) # it will tell you if the credit card is valid
```

Pass them the credit card as string to make them work.

You can also use the module `CreditCardValidation`, which is a GenServer, and will evaluate and save your validations as state.

```elixir
CreditCardValidation.start_link() # Will start the GenServer
CreditCardValidation.validate_credit_card(credit_card) # Will evaluate and save every credit card you pass
CreditCardValidation.get_validations() # You can get all the credit cards that you have evaluated so far

# The format that get_validations() return is
[
  {"4111111111111111", {:ok, "Visa"}, true},
  {"4111111111111", {:ok, "Visa"}, false},
  {"4012888888881882", {:error, "Unknown"}, false}
]

# Every element of the list contains a tuple, being the first element the credit card, the second one the type (a tuple with :ok or :error and the type), and the last one a boolean for indicating if it's valid or not.
```

## Installation as command line program

Clone or download this repository. Unzip the file, and execute `./credit_card_validation`.

Follow the instructions, introducing one credit card per line, and `exit` to finish.

You need [Elixir](https://elixir-lang.org/) as dependency, so make sure you have it in your system.

## Compiling the command line program

Run `mix escript.build` for compiling the results given by the CLI
