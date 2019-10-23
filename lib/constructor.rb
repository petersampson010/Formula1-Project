class Constructor < ActiveRecord::Base

    has_many :drivers
    has_one :game

    def pick_driver(driver)
        self.drivers << driver
    end 

    def budget 
        sum = 14
        self.drivers.each do |d|
            sum -= d.price
        end 
        sum
    end 

end 
