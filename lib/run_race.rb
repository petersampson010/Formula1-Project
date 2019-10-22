require_relative '../config/environment'

puts 'runs'

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


  # returns nil
end