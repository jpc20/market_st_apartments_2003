class Apartment

  def initialize(information)
    @information = information
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

end
