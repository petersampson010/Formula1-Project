class Constructor < ActiveRecord::Base

  has_many :drivers

  def pick_driver(driver1)
    drivers << driver1
  end

end 
