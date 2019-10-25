class Constructor < ActiveRecord::Base

  has_many :drivers


  def pick_driver(driver)
    drivers << driver
  end

  def increase_techfactor(tech_points)
    self.tech_factor += tech_points
  end



    def after_driver_selection
        drivers.each do |d|
          Constructor.budget -= d.price 
        end 
        Constructor.budget
    end 
end 
