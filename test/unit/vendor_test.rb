# -*- coding: utf-8 -*-
require 'test_helper'

class VendorTest < ActiveSupport::TestCase
  def test_valide_vendors
    vendor = Vendor.create(:full_name   => "Penny Price",
                           :abbr_name   => "PPA",
                           :currency_id => 2,
                           :active      => false)
    assert_valid(vendor)
  end
end
