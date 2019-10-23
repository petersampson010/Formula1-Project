class FinishingPosition < ActiveRecord::Base

    belongs_to :race
    belongs_to :driver 
    belongs_to :game

end 