class Game < ActiveRecord::Base

    has_many :finishing_positions

    def budget
        sum = 14
        drivers.each do |d|
          sum -= d.price 
        end 
        sum 
    end 
end 