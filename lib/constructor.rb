class Constructor < ActiveRecord::Base

    has_many :drivers

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

    def self.single_drivers
        Constructor.all.select {|team| team.drivers.size == 1}
    end 

    def self.fill_teams
        stroll = Driver.find_by(id: 17)
        perez = Driver.find_by(id: 18)
        Constructor.single_drivers[0].drivers << stroll 
        Constructor.single_drivers[0].drivers << perez
    end 



end 
