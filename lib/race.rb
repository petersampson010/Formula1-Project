class Race < ActiveRecord::Base

  has_many :drivers, through: :finishing_positions
  has_many :finishing_positions

  def determine_racescore(driver)
    # creates a race score for a drive
    skill = driver.skill_factor
    technology = driver.constructor.tech_factor
    rand * 10.floor * skill * technology
    # returns a score value
  end

  def racescores(drivers)
    # maps each driver to his/her race score
    drivers.map { |driver| [determine_racescore(driver), driver] }
    # returns an array of arrays [score, driver instance]
  end

  def sorted_racescores(drivers)
    # gets racescore for drivers and sorts them
    racescores(drivers).sort { |a, b| a[0] <=> b[0] }
    # returns an sorted array of arrays [score, driver instance]
  end

  def ranking(drivers)
    sorted_racescores(drivers).each_with_index.map do |scorecard, index|
      [index + 1, scorecard[1]]
    end
    # returns an array of arrays [position, driver instance]
  end

  def print_ranking(drivers)
    # iterates through ranking and prints each rank with position and lastname
    ranking(drivers).each do |rank|
      puts rank[0] + '. ' + rank[1].last_name
    end
    # returns nil
  end

  # def run_race(drivers)
  #   # call function to create scoreboard, sort it, create FinishingPositions
  #   sorted_sb = create_scoreboard(drivers).sort { |a, b| a[0] <=> b[0] }
    
  #   sorted_sb.each_with_index do |scorecard, index|
  #     driver_id = scorecard[1].id
  #     fp = FinishingPosition.create(final_position: index + 1, driver_id: driver_id, race_id: self.id)
  #     #self.finishing_positions << fp
  #   end

  # end

end 
