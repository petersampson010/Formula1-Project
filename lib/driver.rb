class Driver < ActiveRecord::Base

    belongs_to :constructor 
    has_many :finishing_positions
    has_many :races, through: :finishing_positions

end 