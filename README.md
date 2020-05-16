# CreditCardValidation

CreditCardValidation is a command line program, as well as an elixir library, to find out whether a Credit Card is valid, and its type.

So far it only checks among the types: MasterCard, VISA, Discover and AMEX.

## Installation as library for your project

Add `credit_card_validation` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:credit_card_validation, git: "git://github.com/alexanderttalvarez/credit_vard_validation.git", tag: "v0.1.0"}}
  ]
end
```

## Installation as command line program

Clone

## Compiling the command line program

Run `mix escript.build` for compiling the results given by the CLI
