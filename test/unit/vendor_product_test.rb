# -*- coding: utf-8 -*-
require 'test_helper'

class VendorProductTest < ActiveSupport::TestCase
  def test_capacity_should_be_number
    ok = %w{ 1 1.0 99 99.9 }
    bad = %w{ 1。0 abc }

    ok.each do |cap|
      vp = VendorProduct.new(:title => "test",
                             :vendor_id => 1,
                             :capacity => cap,
                             :price => 1.1,
                             :active => true)
      assert vp.valid?, vp.errors.full_messages
    end

    bad.each do |cap|
      vp = VendorProduct.new(:title => "test",
                             :vendor_id => 1,
                             :capacity => cap,
                             :price => 1.1,
                             :active => true)
      assert !vp.valid?, "capacity is #{cap}, which should be invalid."
    end
  end

  def test_price_should_be_number
    ok = %w{ 1 1.0 99 99.9 }
    bad = %w{ 1。0 abc }

    ok.each do |price|
      vp = VendorProduct.new(:title => "test",
                             :vendor_id => 1,
                             :capacity => 1.1,
                             :price => price,
                             :active => true)
      assert vp.valid?, vp.errors.full_messages
    end

    bad.each do |price|
      vp = VendorProduct.new(:title => "test",
                             :vendor_id => 1,
                             :capacity => 1.1,
                             :price => price,
                             :active => true)
      assert !vp.valid?, "price is #{price}, which should be invalid."
    end
  end
end
