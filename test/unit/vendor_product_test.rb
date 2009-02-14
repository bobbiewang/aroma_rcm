# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class VendorProductTest < ActiveSupport::TestCase
  def test_duplicate_title
    # 同一个 vendor 不能有同名的产品
    vp = VendorProduct.new(:title => vendor_products(:oil).title,
                           :vendor_id => vendor_products(:oil).id,
                           :capacity => 1,
                           :price => 9.9,
                           :active => true)
    assert !vp.valid?, "Duplicate title."
    assert vp.errors.invalid?(:title)
    assert_equal ActiveRecord::Errors.default_error_messages[:taken],
                 vp.errors.on(:title)

    # 不同 vendor 可以有同名的产品
    vp.vendor_id = vendor_products(:oil).id + 1
    assert vp.valid?, vp.errors.full_messages
  end

  def test_capacity_should_be_number_or_nil
    nums = %w{ 1 1.0 99 99.9 }
    nans = %w{ 1。0 abc }

    # 合法数字
    nums.each do |cap|
      vp = VendorProduct.new(:title => "test",
                             :vendor_id => 1,
                             :capacity => cap,
                             :price => 1.1,
                             :active => true)
      assert vp.valid?, vp.errors.full_messages
    end

    # 非法数字
    nans.each do |cap|
      vp = VendorProduct.new(:title => "test",
                             :vendor_id => 1,
                             :capacity => cap,
                             :price => 1.1,
                             :active => true)
      assert !vp.valid?, "capacity is #{cap}, which should be invalid."
    end

    # nil，如木盒
    vp = VendorProduct.new(:title => "test",
                           :vendor_id => 1,
                           :price => 1.1,
                           :active => true)
    assert vp.valid?, vp.errors.full_messages
  end

  def test_price_should_be_number_or_nil
    nums = %w{ 1 1.0 99 99.9 }
    nans = %w{ 1。0 abc }

    # 合法数字
    nums.each do |price|
      vp = VendorProduct.new(:title => "test",
                             :vendor_id => 1,
                             :capacity => 1.1,
                             :price => price,
                             :active => true)
      assert vp.valid?, vp.errors.full_messages
    end

    # 非法数字
    nans.each do |price|
      vp = VendorProduct.new(:title => "test",
                             :vendor_id => 1,
                             :capacity => 1.1,
                             :price => price,
                             :active => true)
      assert !vp.valid?, "price is #{price}, which should be invalid."
    end

    # nil，比如某些自制产品，在制作（销售）前不能确定成本
    vp = VendorProduct.new(:title => "test",
                           :vendor_id => 1,
                           :capacity => 10)
    assert vp.valid?, vp.errors.full_messages
  end
end
