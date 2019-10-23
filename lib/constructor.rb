class Constructor < ActiveRecord::Base

<<<<<<< HEAD
    has_many :drivers
    has_one :game
=======
  has_many :drivers
>>>>>>> 0919_simulaterace

  def pick_driver(driver)
    drivers << driver
  end

  def budget
    sum = 14
    drivers.each do |d|
      sum -= d.price
    end
    sum
  end

  def increase_techfactor(tech_points)
    self.tech_factor += tech_points
  end

end
