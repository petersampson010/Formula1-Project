class Race < ActiveRecord::Base

    has_many :drivers, through: :finishing_positions
    has_many finishing_positions


end 
