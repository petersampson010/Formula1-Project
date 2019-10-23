class Driver < ActiveRecord::Base

  belongs_to :constructor
  has_many :finishing_positions
  has_many :races, through: :finishing_positions

  def self.driver_points
    Driver.all.map { |driver| [driver.points, driver] }
    # returns an array of arrays [points, driver]
  end

  def self.ranked_driver_points
    Driver.driver_points.sort { |a, b| a[0] <=> b[0] }.reverse
    # returns an sorted (desc) array of arrays [points, driver]
  end

  def self.show_standings
    puts 'Rank - Driver - Points - Wins'
    Driver.ranked_driver_points.each_with_index do |standing, index|
      puts "#{index + 1}. #{standing[1].name} #{standing[0]} #{standing[1].wins}"
    end
  end

  def name
    "#{first_name} #{second_name}"
  end

  def positions
    # gets all positions in races for instance
    finishing_positions.map(&:final_position)
    # returns an array of positions
  end

  def points
    # sums all points a driver has earned
    positions.reduce { |sum, pos| sum + points_per_position(pos) }
    # return total points > interger
  end

  def wins
    positions.select { |pos| pos == 1 }.size
  end

  def increase_skill(skill_points)
    self.skill_factor += skill_points
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