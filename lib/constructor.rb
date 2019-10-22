class Constructor < ActiveRecord::Base

    has_many :drivers

    def pick_driver 
        
    end 

    # def pick_driver1
    #     puts "Take a look through all the drivers and select one by entering their number:"
    #     driver1_id = gets.strip 
    #     driver1 = Driver.find_by(id: driver1_id)
    #     driver1.constructor_id = team_id
    #     Constructor.find_by(id: team_id).drivers << driver1
    #     puts "Great choice, #{driver1.first_name} has been on fire pre-season! You now have #{14 - driver1.price} to spend on your second driver"
    # end 

end 
