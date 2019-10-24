require 'pry'
class Race < ActiveRecord::Base

  has_many :drivers, through: :finishing_positions
  has_many :finishing_positions


  def determine_race_score(driver)
    # creates a race score for a driver
    skill = driver.skill_factor
    technology = 1 #   driver.constructor.tech_factor
    rand #     * 10 * skill * technology
    # returns an integer > score
  end

  def get_scorecards(drivers)
    # maps each driver to his/her race score
    drivers.map { |driver| [determine_race_score(driver), driver] }
    # returns an array of arrays > [score, driver instance]
  end

  def sort_scorecards(drivers)
    # gets racescore for drivers and sorts them
    get_scorecards(drivers).sort { |a, b| a[0] <=> b[0] }
    # returns an sorted array of arrays > [score, driver instance]
  end

  def get_ranking(drivers)
    sort_scorecards(drivers).each_with_index.map do |scorecard, index|
      [index + 1, scorecard[1]]
    end
    # returns an array of arrays > [position, driver instance]
  end

  def show_ranking(drivers)
    # iterates through ranking and prints each rank with position and lastname
    puts ' Position | Driver '
    get_ranking(drivers).each do |rank|
      puts "#{rank[0]}. #{rank[1].name} "
    end
    # returns nil
  end

  def run_race(drivers)
    # get ranking, save FinishingPositions to Database

    get_ranking(drivers).each do |rank|
      FinishingPosition.create(final_position: rank[0], driver_id: rank[1].id, race_id: self.id)
    end
  end
end 
