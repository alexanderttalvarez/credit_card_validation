defmodule CreditCardValidationTest do
  use ExUnit.Case

  @credit_card_1 "4111111111111111"
  @credit_card_2 "4111111111111"
  @credit_card_3 "4012888888881881"
  @credit_card_4 "378282246310005"
  @credit_card_5 "6011111111111117"
  @credit_card_6 "5105105105105100"
  @credit_card_7 "5105 1051 0510 5106"
  @credit_card_8 "9111111111111111"

  setup do
    CreditCardValidation.start_link()
    :ok
  end

  describe "Validate credit cards" do
    test "Validate VISA" do
      CreditCardValidation.validate_credit_card(@credit_card_1)
      CreditCardValidation.validate_credit_card(@credit_card_2)
      CreditCardValidation.validate_credit_card(@credit_card_3)

      assert CreditCardValidation.get_validations() == [
        {"4111111111111111", {:ok, "Visa"}, true},
        {"4111111111111", {:ok, "Visa"}, false},
        {"4012888888881881", {:ok, "Visa"}, true}
      ]
    end

    test "Validate unknown" do
      CreditCardValidation.validate_credit_card(@credit_card_8)

      assert CreditCardValidation.get_validations() == [{"9111111111111111", {:error, "Unknown"}, false}]
    end

    test "Validate all types" do
      CreditCardValidation.validate_credit_card(@credit_card_1)
      CreditCardValidation.validate_credit_card(@credit_card_2)
      CreditCardValidation.validate_credit_card(@credit_card_3)
      CreditCardValidation.validate_credit_card(@credit_card_4)
      CreditCardValidation.validate_credit_card(@credit_card_5)
      CreditCardValidation.validate_credit_card(@credit_card_6)
      CreditCardValidation.validate_credit_card(@credit_card_7)
      CreditCardValidation.validate_credit_card(@credit_card_8)

      assert CreditCardValidation.get_validations() == [
        {"4111111111111111", {:ok, "Visa"}, true},
        {"4111111111111", {:ok, "Visa"}, false},
        {"4012888888881881", {:ok, "Visa"}, true},
        {"378282246310005", {:ok, "Amex"}, true},
        {"6011111111111117", {:ok, "Discover"}, true},
        {"5105105105105100", {:ok, "MasterCard"}, true},
        {"5105 1051 0510 5106", {:ok, "MasterCard"}, false},
        {"9111111111111111", {:error, "Unknown"}, false}
      ]

    end
  end

end
