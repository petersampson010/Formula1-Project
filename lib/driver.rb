class Driver < ActiveRecord::Base

    attr_reader :points

    belongs_to :constructor
    has_many :finishing_positions
    has_many :races, through: :finishing_positions

    def name
        "#{self.first_name} #{self.second_name}"
    end

  def points
    require_relative
    self.finishing_positions.map do |fp|
        fp[2]
    end
  end

end 