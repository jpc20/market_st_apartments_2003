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
end
