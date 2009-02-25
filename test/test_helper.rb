# -*- coding: undecided -*-
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

<<EOS

  - Postage:     420 （各 postage weight 之和）
  - Total Price: 150
  - Total Price with Postage: 570
  - Total Cost: 1140

  |----------+-----+-------+-------+---------+---------+------+-------+-------|
  | Vendor   | QTY |  Item | Total | Postage |   Total | Item | Saled | Saled |
  | Product  |     | Price | Price |  Weight | Pweight | Cost |   QTY | Price |
  |----------+-----+-------+-------+---------+---------+------+-------+-------|
  | oil      |   4 |     5 |    20 |      10 |      40 |   30 |     1 |   100 |
  | hydrolat |   3 |    10 |    30 |      50 |     150 |  120 |     2 |   200 |
  | box      |  10 |     5 |    50 |       1 |      10 |   12 |       |       |
  |----------+-----+-------+-------+---------+---------+------+-------+-------|

  |----------+-----+-------+-------+---------+---------+------+--------+------+-----------+------------|
  | Material | QTY |  Item | Totol | Postage |   Total | Item | Amount | Unit | Used  for |   Used for |
  |          |     | Price | Price |  Weight | Pweight | Cost |        | Cost | DIY cream | DIY lotion |
  |----------+-----+-------+-------+---------+---------+------+--------+------+-----------+------------|
  | oil      |   2 |     5 |    10 |      10 |      20 |   30 |    200 | 0.15 |         2 |          1 |
  | hydrolat |   4 |    10 |    40 |      50 |     200 |  120 |     50 |  2.4 |        30 |         60 |
  |----------+-----+-------+-------+---------+---------+------+--------+------+-----------+------------|

EOS
