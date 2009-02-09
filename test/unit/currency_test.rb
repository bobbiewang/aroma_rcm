require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_invalid_with_empty_attributes
    currency = Currency.new
    assert !currency.valid?, "Empty Currency should be invalid."
    assert currency.errors.invalid?(:full_name), "Currency.full_name shouldn't be empty."
    assert currency.errors.invalid?(:iso_code), "Currency.iso_code shouldn't be empty."
    assert currency.errors.invalid?(:symbol), "Currency.symbol shouldn't be empty."
  end
end
