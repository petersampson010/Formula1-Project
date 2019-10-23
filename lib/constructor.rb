class Constructor < ActiveRecord::Base


    has_many :drivers
    has_one :game


  def pick_driver(driver)
    drivers << driver
  end

  def increase_techfactor(tech_points)
    self.tech_factor += tech_points
  end

end
