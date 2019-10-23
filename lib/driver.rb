class Driver < ActiveRecord::Base

  attr_reader :points

  belongs_to :constructor
  has_many :finishing_positions
  has_many :races, through: :finishing_positions

  def name
    "#{self.first_name} #{self.second_name}"
  end

  def positions
    # gets all positions in races for instance
    self.finishing_positions.map do |fp|
      position = fp.final_position
    end
    # returns array of positions
  end

  def points
    positions.reduce { |sum, pos| sum + earned_points_per_position(pos) }
  end

  def self.reset_drivers_to_teams
    Driver.all.each do |d|
      if d.id.even? 
        d.constructor_id = d.id/2
      else 
        d.constructor_id = (d.id/2)+0.5
      end 
    end 
  end 

  def fill_empty_teams
  end 

end 