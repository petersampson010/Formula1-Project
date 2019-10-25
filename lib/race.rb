require 'pry'
class Race < ActiveRecord::Base

  has_many :drivers, through: :finishing_positions
  has_many :finishing_positions


  def determine_race_score(driver)
    # creates a race score for a driver
    skill = driver.skill_factor
    technology = driver.constructor.tech_factor
    rand * 10 * skill * technology
    # returns an integer > score
  end

  def get_scorecards(drivers)
    # maps each driver to his/her race score
    drivers.map { |driver| [determine_race_score(driver), driver] }
    # returns an array of arrays > [score, driver instance]
  end

  def sort_scorecards(drivers)
    # gets racescore for drivers and sorts them
    get_scorecards(drivers).sort { |a, b| b[0] <=> a[0] }
    # returns an sorted array of arrays > [score, driver instance]
  end

  def get_ranked_scorecards(drivers)
    sort_scorecards(drivers).each_with_index.map do |scorecard, index|
      [index + 1, scorecard[1]]
    end
    # returns an array of arrays > [position, driver instance]
  end

  def run_race(drivers)
    # get ranking, save FinishingPositions to Database

    get_ranked_scorecards(drivers).each do |rank|
      FinishingPosition.create(final_position: rank[0], driver_id: rank[1].id, race_id: id, game_id: game_id )
    end
  end

  def drivers_finishingposition
    FinishingPosition.select do |fp|
      fp.race_id == id && fp.game_id == game_id
    end
    # returns an array of instances [,,,]
  end


  def show_ranking
    puts ' '
    puts "Live from #{circuit}, we just got the final results:"
    puts ' '
    puts ' Position | Driver   | Team'
    puts '----------------------------------------------'
    drivers_finishingposition.each do |fp|

      puts "#{fp.final_position} | #{fp.driver.name} | #{Constructor.find_by(id: fp.driver.constructor_id).name}"
    end
    puts ' '
  end

end 
