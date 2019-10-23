class Game < ActiveRecord::Base

    has_many :finishing_positions
    has_one :constructor

    

end 