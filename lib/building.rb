class Building

  attr_reader :units
  def initialize
    @units = []
  end

  def add_unit(unit)
    @units << unit
  end

  def renters
    return [] if @units.none?{ |unit| unit.renter }
    @units.map do |unit|
      unit.renter.name
    end
  end

  def average_rent
    total_rent = @units.sum do |unit|
      unit.monthly_rent
    end

    total_rent.to_f / @units.length.to_f
  end

  def rented_units
    @units.find_all do |unit|
      unit.renter
    end
  end

  def renter_with_highest_rent
    most_expensive_rented_unit = rented_units.max_by do |unit|
      unit.monthly_rent
    end
    most_expensive_rented_unit.renter
  end
end
