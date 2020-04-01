require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'
require './lib/apartment'
require './lib/building'

class BuildingTest < Minitest::Test

  def setup
    @building = Building.new
    @unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    @unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    @unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    @unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    @renter1 = Renter.new("Aurora")
    @renter2 = Renter.new("Tim")
    @renter3 = Renter.new("Spencer")
    @renter4 = Renter.new("Jessie")
    @renter5 = Renter.new("Max")
  end

  def test_it_exists
    assert_instance_of Building, @building
  end

  def test_units_empty_by_default
    assert_equal [], @building.units
  end

  def test_add_unit
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)

    assert_equal [@unit1, @unit2], @building.units
  end

  def test_renters_empty_by_default
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)

    assert_equal [], @building.renters
  end

  def test_renters_after_adding_renters_to_units
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @unit1.add_renter(@renter1)

    assert_equal ["Aurora"], @building.renters

    @unit2.add_renter(@renter2)

    assert_equal ["Aurora", "Tim"], @building.renters
  end

  def test_average_rent
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @unit1.add_renter(@renter1)
    @unit2.add_renter(@renter2)

    assert_equal 1099.5, @building.average_rent
  end

  def test_rented_units
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)

    assert_equal [], @building.rented_units

    @unit2.add_renter(@renter3)

    assert_equal [@unit2], @building.rented_units
  end

  def test_renter_with_highest_rent
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @unit2.add_renter(@renter3)

    assert_equal @renter3, @building.renter_with_highest_rent

    @unit1.add_renter(@renter4)

    assert_equal @renter4, @building.renter_with_highest_rent

    @unit3.add_renter(@renter5)

    assert_equal @renter4, @building.renter_with_highest_rent
  end

  def test_units_by_number_of_bedrooms
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @building.add_unit(@unit4)

    assert_equal ({ 3 => ["D4" ], 2 => ["B2", "C3"], 1 => ["A1"]}), @building.units_by_number_of_bedrooms
  end

  def test_annual_breakdown
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @unit2.add_renter(@renter3)

    assert_equal ({"Spencer" => 11988}), @building.annual_breakdown

    @unit1.add_renter(@renter4)

    assert_equal ({"Jessie" => 14400, "Spencer" => 11988}), @building.annual_breakdown
  end

  def test_rooms_by_renter
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @unit2.add_renter(@renter3)
    @unit1.add_renter(@renter4)

    assert_equal ({@renter4 => {bathrooms: 1, bedrooms: 1}, @renter3 => {bathrooms: 2, bedrooms: 2}}), @building.rooms_by_renter
  end

end
