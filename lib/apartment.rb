class Apartment
  
  attr_reader :renter
  def initialize(information)
    @information = information
    @renter = nil
  end

  def number
    @information[:number]
  end

  def monthly_rent
    @information[:monthly_rent]
  end

  def bathrooms
    @information[:bathrooms]
  end

  def bedrooms
    @information[:bedrooms]
  end

  def add_renter(renter)
    @renter = renter
  end

end
