require 'pry'
require 'tty-prompt'

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

  
  # REFERENCE DATA > A TABLE??

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

  def setup_game_data
    seed_data(id)
  end

  def require_team_name
    puts 'Please enter your team name:'
    gets.strip
  end

  def require_team_nationality
    puts 'Please enter the country your team has originated from:'
    gets.strip
  end

  def create_team
    team_name = require_team_name
    team_nationality = require_team_nationality
    our_team = Constructor.create(
      name: team_name,
      nationality: team_nationality,
      tech_factor: 0.3,
      budget: 100,
      game_id: id
    )
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
    selectable_drivers.each_with_index do |driver, index|
      puts "#{index + 1}. #{driver.name} | Age:#{driver.age} | #{driver.nationality} | Price:#{driver.price}"
    end
    puts ' '
  end

  def update_team_budget(balance)
    our_team.update(budget: balance)
  end

  def select_driver
    puts "Please select the number of the driver you'd like to join your team:"
    list_num = gets.strip
    puts ' '
    driver = selectable_drivers[list_num.to_i - 1]
    our_team.pick_driver(driver)
    balance = our_team.budget - driver.price
    update_team_budget(balance)
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
    puts "#{our_team.drivers[0].first_name} has been on fire pre-season."
    puts "You have #{our_team.budget} left for your next driver:"
    puts ' '
  end

  def select_drivers_for_team 
    prompt_user_select_first_driver
    sleep(1)
    list_selectable_drivers
    select_driver
    prompt_user_select_second_driver
    list_selectable_drivers
    select_driver
  end

  def single_drivers
    self.game_constructors.select {|team| team.drivers.size == 1 || team.drivers.size == 0}
  end  

  def fill_teams 
    stroll = Driver.find_by(second_name: "Stroll", game_id: self.id)
    perez = Driver.find_by(second_name: "Perez", game_id: self.id)
    teams_needing = self.single_drivers
    teams_needing[0].drivers << stroll 
    teams_needing[1].drivers << perez 
  end 

  def present_lineup
    puts "And there it is, the lineup for '#{our_team.name}':"
    puts ' '
    puts our_team.drivers[0].name.to_s
    puts our_team.drivers[1].name.to_s
    puts ' '
  end

  
  # RUN A RACE

  def create_race_results(race)
    race.run_race(drivers_in_game)
  end

  def show_race_result_text
    puts 'Live from XX, we just got the final results:'
    puts ' '
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

  ## run a race

 

  def drivers_points
    drivers_in_game.map { |driver| [driver.points, driver] }
    # returns an array of arrays [points, driver]
  end

  def ranked_drivers_points
    drivers_points.sort { |a, b| a[0] <=> b[0] }.reverse
    # returns an sorted (desc) array of arrays [points, driver]
  end

  def show_standing_for_game
    puts 'Rank | Driver | Points | Wins'
    ranked_drivers_points.each_with_index do |standing, index|
      puts "#{index + 1} | #{standing[1].name} | #{standing[0]} | #{standing[1].wins}"
    end
    puts ' '
  end



  def run_season
    show_intro_text
    races = races_in_game[0..1]
    races.each do |race|
      create_race_results(race)
      #show_race_result_text
      require 'pry'
      binding.pry
      # puts "rankings"
      # wait_for_any_key
       show_current_driver_standings
      # puts "standings"
      #wait_for_any_key
    end
  end

  def changes_introduction
    puts "Improving your team is vital throughout the season! Keep winning races and you'll have more to spend!"
    puts "Would you like to make changes to your car or to your driver?"
  end 

    def mid_season_changes 
        prompt = TTY::Prompt.new
        example3 = prompt.select("Would you like to make any changes to the team?", cycle:true) do |menu|
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
            puts "Engine Upgraded!"
            self.our_team.tech_factor += 0.5
        elsif example == 1
            puts "Front Wing Upgraded!"
            self.our_team.tech_factor += 0.2
        elsif example == 2 
            puts "Tyres Upgraded!"
            self.our_team.tech_factor += 0.2
        elsif example == 3 
            puts "Suspension Upgraded!"
            self.our_team.tech_factor += 0.3
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
            puts "Driver Upgraded!"
            self.our_team.drivers[0].skill_factor += 3
        elsif example2 == 1 
            puts "Driver Upgraded!"
            self.our_team.drivers[1].skill_factor += 3 
        end 
    end 
end
