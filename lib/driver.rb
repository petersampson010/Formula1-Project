class Driver < ActiveRecord::Base


    belongs_to :constructor
    has_many :finishing_positions
    has_many :races, through: :finishing_positions

    def name
        "#{self.first_name} #{self.second_name}"
    end

end 