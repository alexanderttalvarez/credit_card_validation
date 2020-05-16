defmodule CreditCardValidation.CardTypes.CardTypesBehaviour do
  @callback begins_with() :: [String.t]
  @callback number_length() :: [integer]
end
