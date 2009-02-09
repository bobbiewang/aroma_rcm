require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  def test_invalid_with_empty_attributes
    currency = Currency.new
    assert !currency.valid?, "Empty Currency should be invalid."
    assert currency.errors.invalid?(:full_name), "Currency.full_name shouldn't be empty."
    assert currency.errors.invalid?(:iso_code), "Currency.iso_code shouldn't be empty."
    assert currency.errors.invalid?(:symbol), "Currency.symbol shouldn't be empty."
  end

  def test_unique_full_name
    currency = Currency.new(:full_name => currencies(:cny).full_name,
                            :iso_code  => "test",
                            :symbol    => "test")
    assert !currency.valid?
    assert_equal ActiveRecord::Errors.default_error_messages[:taken],
                 currency.errors.on(:full_name)
  end

  def test_unique_iso_code
    currency = Currency.new(:full_name => "test",
                            :iso_code  => currencies(:cny).iso_code,
                            :symbol    => "test")
    assert !currency.valid?
    assert_equal ActiveRecord::Errors.default_error_messages[:taken],
                 currency.errors.on(:iso_code)
  end

  def test_multiple_symbol
    currency = Currency.new(:full_name => "test",
                            :iso_code  => "test",
                            :symbol    => currencies(:cny).symbol)
    assert currency.valid?
  end
end
