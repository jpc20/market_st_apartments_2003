require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'
require './lib/apartment'

class ApartmentTest < Minitest::Test

  def setup
    @unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    @renter1 = Renter.new("Jessie")
  end

  def test_it_exists
    assert_instance_of Apartment, @unit1
  end

  def test_it_has_readable_attributes
    assert_equal "A1", @unit1.number
    assert_equal 1200, @unit1.monthly_rent
    assert_equal 1, @unit1.bathrooms
    assert_equal 1, @unit1.bedrooms
  end

  def test_add_renter
    assert_equal nil, @unit1.renter
    @unit1.add_renter(@renter1)
    assert_equal @renter1, @unit1.renter
  end
end
