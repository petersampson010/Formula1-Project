class Race < ActiveRecord::Base

  has_many :drivers, through: :finishing_positions
  has_many :finishing_positions

  def determine_racescore_for_driver(driver)
    # creates a race score for a drive
    skill = driver.skill_factor
    technology = driver.constructor.tech_factor
    rand * 10.floor * skill * technology
    # returns a score value
  end

  def create_drivers_scoreboard(drivers)
    # maps each driver to his/her race score
    drivers.map { |driver| [determine_racescore_for_driver(driver), driver] }
    # returns an array of arrays [score, driver instance]
  end

  def run_race(drivers)
    # call function to create scoreboard, sort it, create FinishingPositions
    sorted_sb = create_drivers_scoreboard(drivers).sort { |a, b| a[0] <=> b[0] }
    sorted_sb.each_with_index do |scorecard, index|
      postion = index + 1
      driver_id = scorecard[1].id
      fp = FinishingPosition.create(final_position: postion, driver_id: driver_id, race_id: self.id)
      self.finishing_positions << fp
    end
 end

end 
