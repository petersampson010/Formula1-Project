require 'pry'

class Game < ActiveRecord::Base

  attr_reader :our_team_id
  has_many :finishing_positions

  @our_team_id = nil

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
    puts "And there it is, the lineup for #{our_team.name} is:"
    puts ' '
    puts our_team.drivers[0].name.to_s
    puts our_team.drivers[1].name.to_s
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

  def wait_for_any_key
    require 'io/console'
    puts "Press any key to continue"
    STDIN.getch   
  end

end
