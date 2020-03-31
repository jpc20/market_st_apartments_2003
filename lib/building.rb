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

  def units_by_number_of_bedrooms
    grouped = @units.group_by do |unit|
      unit.bedrooms
    end

    grouped.each do |num, units|
      grouped[num] = units.map do |unit|
        unit.number
      end
    end

    grouped
  end

  def annual_breakdown
    renter_price_hash = {}

    rented_units.each do |unit|
      renter_price_hash[unit.renter.name] = unit.monthly_rent * 12
    end

    renter_price_hash
  end

  def rooms_by_renter
    rooms_by_renter_hash = {}

    rented_units.each do |unit|
      rooms_by_renter_hash[unit.renter] = {bathrooms: unit.bathrooms, bedrooms: unit.bedrooms}
    end

    rooms_by_renter_hash
  end

end
