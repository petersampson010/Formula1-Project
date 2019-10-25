require 'tty-prompt'
require 'artii'

class Game < ActiveRecord::Base

  attr_reader :our_team_id
  has_many :finishing_positions

  @our_team_id = nil

  # CONTROL FLOW FUNCTIONS

  def wait_for_any_key
    require 'io/console'
    puts ' '
    puts 'Press any key to continue'
    STDIN.getch
  end

  def points_per_position(position)
    case position
    when 1
      25
    when 2
      18
    when 3
      12
    when 4
      10
    when 5
      8
    when 6
      4
    when 7
      2
    when 8..10
      1
    else
      0
    end
  end

  def credits_per_position(position)
    case position
    when 1
      10
    when 2
      8
    when 3
      6
    when 4
      4
    when 5
      2
    when 6
      1
    else
      0
    end
  end

  #PREPARE SEASON


  # Output Text

  def welcome_screen
    puts `clear`
    a = Artii::Base.new :font => 'slant'
    puts a.asciify('FORMULA 1')

  end

  def require_team_name
    puts 'Please enter your team name:'
    gets.strip
  end

  def require_team_nationality
    puts 'Please enter the country your team has originated from:'
    gets.strip
  end

  def prompt_user_select_first_driver
    puts `clear`
    puts 'Now its time to hire some drivers for your season!'
    puts 'Every drivers desperate to be on your books, but watch out,'
    puts 'that lottery fund of £100m will only take you so far'
    puts 'and once a drivers signed that contract hes in for the season!'
    puts ''
  end

  def prompt_user_select_second_driver
    puts ' '
    puts 'Great choice!'
    puts ' '
    puts "#{our_team.drivers[0].first_name} has been on fire pre-season."
    puts "You have #{our_team.budget} left for your next driver:"
    puts ' '
  end

  # Functions

  def setup_game_data
    seed_data(id)
  end

  def create_team
    team_name = require_team_name
    team_nationality = require_team_nationality
    our_team = Constructor.create(
      name: team_name,
      nationality: team_nationality,
      tech_factor: 4.0,
      budget: 100,
      game_id: self.id
    )
    self.users_team = team_name
    @our_team_id = our_team.id
  end

  def game_constructors
    Constructor.all.select { |constructor| constructor.game_id == id }
    # returns an array of constructor instances
  end

  def our_team
    game_constructors.select { |constructor| constructor.id == @our_team_id }[0]
    # returns an instance
  end

  def drivers_in_game
    Driver.all.select { |driver| driver.game_id == id }
    # returns an array of driver instances
  end

  def selectable_drivers
    drivers_in_game.reject do |driver|
      driver.first_name == 'Lance' || driver.first_name == 'Sergio' || driver.price > our_team.budget || driver.first_name == our_team.drivers[0].first_name if our_team.drivers!=[]
    end
  end

  def list_selectable_drivers
    selectable_drivers.map { |d| "Price: #{d.price} | #{d.name}" }
  end

  def select_driver
    prompt = TTY::Prompt.new
    example = prompt.select("Please select the driver you would like to join your team", list_selectable_drivers)
    selectable_drivers.each_with_index do |d, i|
      if example == list_selectable_drivers[i]
                our_team.pick_driver(d)
                balance = our_team.budget - d.price
                update_team_budget(balance)
      end 
    end 
  end 




  # def select_drivers_for_team 
  #   prompt_user_select_first_driver
  #   sleep(1)
  #   list_selectable_drivers
  #   select_driver
  #   prompt_user_select_second_driver
  #   list_selectable_drivers
  #   select_driver
  def update_team_budget(balance)
    our_team.update(budget: balance)
  end


  # def select_drivers_for_team 
  #   prompt_user_select_first_driver
  #   sleep(1)
  #   list_selectable_drivers
  #   select_driver
  #   prompt_user_select_second_driver
  #   list_selectable_drivers
  #   select_driver
  # end

  def teams_not_full_staffed
    game_constructors.select { |team| team.drivers.size < 2 }
    # returns an array of size 2
  end

  def fill_teams
    # teams not fully staffed
    teams_needing_drivers = teams_not_full_staffed
    # replacement drivers
    stroll = Driver.find_by(second_name: "Stroll", game_id: id)
    perez = Driver.find_by(second_name: "Perez", game_id: id)
    # fill it up
    if teams_needing_drivers.size == 2
      stroll.update(constructor_id: teams_needing_drivers[0].id)
      perez.update(constructor_id: teams_needing_drivers[1].id)
    else
      stroll.update(constructor_id: teams_needing_drivers.id)
      perez.update(constructor_id: teams_needing_drivers.id)
    end
  end

  def present_lineup
    puts ' '
    puts "And there it is, the lineup for '#{our_team.name}':"
    puts ' '
    puts our_team.drivers[0].name.to_s
    puts our_team.drivers[1].name.to_s
    puts ' '
  end

  def present_teams
    puts ' '
    puts 'The teams are ready to roll for the new season'
    puts ' '
    puts 'Team | Driver 1 | Driver 2 '
    game_constructors.map do |team|
      print "#{team.name}"
      print " | #{team.drivers[0].name}"
      print " | #{team.drivers[1].name}"
      puts ''
    end



  end

  # RUN A RACE

  def create_race_results(race)
    race.run_race(drivers_in_game)
  end

  def show_race_ranking(race)
    race.show_ranking(drivers_in_game)
  end

  # RUN SEASON

  def show_season_intro_text
    puts '..prepare season..'
  end

  def races_in_game
    Race.all.select { |race| race.game_id == id }
  end


  def driver_finishingpositions_all_races(driver)
    FinishingPosition.all.select do |fp|
      fp.game_id == id && fp.driver_id == driver.id
    end
    # returns an array of instances [,,,]
  end

  def driver_positions_all_races(driver)
    driver_finishingpositions_all_races(driver).map{ |fp| fp.final_position } 
    # returns an array of integers [,,,]
  end

  def driver_points_all_races(driver)
    # sums all points a driver has earned
    driver_positions_all_races(driver).map { |pos| points_per_position(pos) }
    #  return total points > integer
  end

  def driver_total_points(driver)
    # sums all points a driver has earned
    driver_points_all_races(driver).reduce { |sum, point| sum + point }
    #  return total points > integer
  end

  def drivers_total_points
    drivers_in_game.map do |driver|
      [driver_total_points(driver), driver]
    end
  end

  def driver_wins(driver)
    driver_positions_all_races(driver).select { |pos| pos == 1 }.size
    # returns an integer
  end

  def ranked_drivers_total_points
    drivers_total_points.sort { |a, b| a[0] <=> b[0] }.reverse
    # returns an sorted (desc) array of arrays [points, driver]
  end

  def show_standing_for_game

    puts 'Rank | Driver | Points'# | Wins'
    ranked_drivers_total_points.each_with_index do |standing, index|
      puts "#{index + 1} | #{standing[1].name} | #{standing[0]} }"#| #{standing[1].wins}"
    end
    puts ' '
  end

## Team Rankings


# def team_scoreboard
#   puts 'Rank   | Team         | Driver      | Driver      '# | Points | Wins'
#   game_constructors.each_with_index.map do |team, index|
#     [index +1, team.name, team.drivers[0], team.drivers[1], '', '']
#   end
# end

def team_scoreboard
  game_constructors.map do |team|
    [driver_total_points(team.drivers[0]) + driver_total_points(team.drivers[1]), team.name]
  end
end

def sorted_team_scoreboard
  team_scoreboard.sort { |a, b| b[0] <=> a[0] }
  # returns an array of arrays
end

def show_constructor_standings
  puts 'Points   | Team '
  sorted_team_scoreboard.each do |standing|
    puts "#{standing[0]} | #{standing[1]}"
  end
end

def show_winning_constructor
  puts ''
  puts "This season's winning team was #{sorted_team_scoreboard[0][1]}"
  puts ''
end

  def changes_introduction
    puts "Improving your team is vital throughout the season! Keep winning races and you'll have more to spend!"
    puts "Would you like to make changes to your car or to your driver?"
  end 

    def mid_season_changes 
        prompt = TTY::Prompt.new
        example3 = prompt.select("Would you like to make any changes to the team? You have a budget of #{our_team.budget}", cycle:true) do |menu|
            menu.choice "No", 0
            menu.choice "Car", 1
            menu.choice "Drivers", 2
        end 
        if example3 == 0 
            puts "Confident in your team, lets push on to the next race"
        elsif example3 == 1 
            select_car_part
        elsif
            driver_improvements
        end 
    end 
    
    def select_car_part 
        prompt = TTY::Prompt.new
        example = prompt.select("Scroll through the car elements and select the part you would like to improve", cycle:true) do |menu|
            menu.choice "Engine: £3", 0
            menu.choice "Front Wing: £1", 1
            menu.choice "Tyres: £1", 2
            menu.choice "Suspension: £2", 3
        end
        if example == 0 
          if our_team.budget >= 3
            puts "Engine Upgraded!"
            self.our_team.update(tech_factor: self.our_team.tech_factor += 0.5)
            self.our_team.update(budget: our_team.budget -=3)
          else 
            puts "You cant afford this! you only have £#{our_team.budget} left"
          end 
        elsif example == 1
          if our_team.budget >= 1
            puts "Front Wing Upgraded!"
            self.our_team.update(tech_factor: self.our_team.tech_factor += 0.1)
            self.our_team.update(budget: our_team.budget -=1)
          else 
            puts "You cant afford this! you only have £#{our_team.budget} left"
          end 
        elsif example == 2 
          if our_team.budget >= 1
            puts "Tyres Upgraded!"
            self.our_team.update(tech_factor: self.our_team.tech_factor += 0.2)
            self.our_team.update(budget: our_team.budget -=1)
          else 
            puts "You cant afford this! you only have £#{our_team.budget} left"
          end 
        elsif example == 3 
          if our_team.budget >= 2
            puts "Suspension Upgraded!"
            self.our_team.update(tech_factor: self.our_team.tech_factor += 0.3)
            self.our_team.update(budget: our_team.budget -=2)
          else 
            puts "You cant afford this! you only have £#{our_team.budget} left"
          end 
        end 
    end 

    def drivers_names 
        ["#{self.our_team.drivers[0].first_name} #{self.our_team.drivers[0].second_name}", "#{self.our_team.drivers[1].first_name} #{self.our_team.drivers[1].second_name}"]
    end 

    def driver_improvements 
        prompt = TTY::Prompt.new
        example2 = prompt.select("Which driver would you like to improve? Each Training session costs £3", cycle:true) do |menu|
            menu.choice "#{self.drivers_names[0]}", 0
            menu.choice "#{self.drivers_names[1]}", 1
        end 
        if example2 == 0
          if our_team.budget >= 3
            puts "Driver Upgraded!"
            our_team.drivers[0].update(skill_factor: our_team.drivers[0].skill_factor += 0.5)
            self.our_team.update(budget: our_team.budget -=3)
          else 
            puts "You cant afford this! you only have £#{our_team.budget} left"
          end 
        elsif example2 == 1 
          if our_team.budget >= 3
            puts "Driver Upgraded!"
            our_team.drivers[1].update(skill_factor: our_team.drivers[1].skill_factor += 0.5)
            self.our_team.update(budget: our_team.budget -=3)
          else 
            puts "You cant afford this! you only have £#{our_team.budget} left"
          end 
        end 
    end 


  def end_season_stats
    races_in_game.map do |race|
      [race.circuit, FinishingPosition.all.find_by(race_id: race.id, driver_id: our_team.drivers[0].id).final_position, FinishingPosition.all.find_by(race_id: race.id, driver_id: our_team.drivers[1].id).final_position]
    end
  end

  def show_winning_constructor
    puts ''
    puts "This season's winning team was #{sorted_team_scoreboard[0][1]}"
    puts ''
  end

  def show_end_season_stats
    puts ' '
    a = Artii::Base.new :font => 'slant'
    puts a.asciify('Le Fin')
    puts ''
    puts 'Well, done! What an eventful season'
    puts ''
    show_winning_constructor
    puts ''
    show_constructor_standings
    puts ''
    wait_for_any_key
    puts "Let's see how you did."
    puts ''
    puts 'Circuit   | Driver 1  Position | Driver 2 Position '
    puts '--------------------------------------'
    end_season_stats.each do |stat|
      puts "#{stat[0]} | #{stat[1]} | #{stat[2]}"
    end
    puts '--------------------------------------'
    puts  "Total  | #{driver_total_points(our_team.drivers[0])} | #{driver_total_points(our_team.drivers[1])} "
    puts ''
    puts "Congrats again and see you next season!"
  end

end
