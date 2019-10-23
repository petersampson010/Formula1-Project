class Game < ActiveRecord::Base

    attr_reader :our_team_id

    has_many :finishing_positions

        @our_team_id = nil


    def setup_game_data
        seed_data(self.id)
    end 

    def introduction 
    end 
    
    def create_team
        puts "Please enter your team name:"
        team_name = gets.strip 
        puts "Please enter the country your team has originated from:"
        team_nationality = gets.strip
        our_team = Constructor.create(name: team_name, nationality: team_nationality, tech_factor: 0.5, budget: 100, game_id: self.id)
        @our_team_id = our_team.id
    end 

    def game_drivers 
      Driver.all.select {|d| d.game_id == self.id}
      # returns an array of driver instances
    end 

    def game_constructors 
      Constructor.all.select {|c| c.game_id == self.id}
      # returns an array of constructor instances
    end 

    def our_team 
      game_constructors.select {|c| c.id == @our_team_id}
      # returns an instance
    end 

    def available_drivers 
      game_drivers.reject { |d| d.first_name == "Lance" || d.first_name == "Sergio" }
      # returns an array of instances
    end

    def available_drivers_by_budget(budget)
      game_drivers.reject { |d| d.first_name == "Lance" || d.first_name == "Sergio" || d.price > budget }
      # returns an array of instance
    end

    def map_drivers
      available_drivers.each_with_index.map { |d, index| [index + 1, d] }
      # returns an array of arrays
    end 

    def show_drivers(drivers) 
      map_drivers.each do |d| 
        puts "#{d[0]}. #{d[1].first_name} #{d[1].second_name} | Age:#{d[1].age} | #{d[1].nationality} | Price:#{d[1].price}"
      end 
      # return nil
    end 

    def list_drivers 
      puts `clear`
      puts "Now its time to hire some drivers for your season!" 
      puts "Every drivers desperate to be on your books but watch out,"
      puts "that lottery fund of £100m will only take you so far and once a drivers signed that contract hes in for the season!"
      sleep(2)
      show_drivers
      driver_one_selection
      driver_two_selection
      present_lineup   
    end 

    def driver_one_selection
        puts "please select the number of the driver you'd like to join your team:"
        list_num = gets.strip
        driver1 = game_drivers[list_num - 1]
        self.our_team.pick_driver(driver1)
        puts "Great choice! #{self.our_team.drivers[0].first_name} has been on fire pre-season. You have #{self.our_team.budget} left for your next driver:"
    end

    def driver_two_selection

    end

        driver2_id = gets.strip 
        until driver2_id != driver1_id do
            if enough_money? 
                driver2 = game_drivers[driver2_id - 1]
                self.our_team.pick_driver(driver2)
            else 
                puts "You havent got the money for this driver, please select again:"
        
    end 

    def driver_two_selection 
        driver2_id = gets.strip 
        if driver2_id == 

        
    end



def driver_two_selection(users_team)
    driver2_id = gets.strip
    binding pry
    if driver2_id == 
        puts "You cant select the same driver twice!, please try again"
        driver_two_selection(users_team)
    else 
        driver2 = game_driver.find_by(id: driver2_id)
        if enough_money?(users_team, driver2)
            users_team.pick_driver(driver2)
        else 
            puts "You havent got the money for this driver, please select again:"
            driver_two_selection(users_team)
        end 
    end 
end 

def enough_money?(users_team, driver)
    if users_team.budget >= driver.price 
        return true 
    else 
        return false 
    end 
end 

def present_lineup
    puts "And there it is, the lineup for #{users_team.name} is:"
    puts "#{users_team.drivers[0].first_name} #{users_team.drivers[0].second_name}"
    puts "#{users_team.drivers[1].first_name} #{users_team.drivers[1].second_name}"
end

