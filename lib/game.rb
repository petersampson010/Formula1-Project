class Game < ActiveRecord::Base

    has_many :finishing_positions

    @start_budget = 100
    @start_tech_factor = 0.5

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
        current_game.users_team = team_name
        Constructor.create(name: team_name, nationality: team_nationality, tech_factor: @start_tech_factor, budget: @start_budget, game_id: self.id)
    end 

    def game_drivers 
        Driver.all.select {|d| d.game_id == self.id}
    end 

    def available_drivers 
        game_drivers.reject {|d| d.first_name == "Lance" || d.first_name == "Sergio"}
    end

    def map_drivers
        available_drivers.each_with_index.map {|d, index| [index+1, d]}
    end 

    # puts "#{index+1}. #{d.first_name} #{d.second_name} | Age:#{d.age} | #{d.nationality} | Price:#{d.price}"}
    # end 

    def show_drivers 
        map_drivers.each do |d| 
            puts "#{d[0]}. #{d[1].first_name} #{d[1].second_name} | Age:#{d[1].age} | #{d[1].nationality} | Price:#{d[1].price}"
        end 
    end 



    def list_drivers 
        puts `clear`
        puts "Now its time to hire some drivers for your season!" 
        puts "Every drivers desperate to be on your books but watch out, that lottery fund of £100m will only take you so far and once a drivers signed that contract hes in for the season!"
        sleep(2)
        show_drivers
    end 

    def select_drivers
        puts "please select the number of the driver you'd like to join your team:"

        puts "Great choice! #{driver1.first_name} has been on fire pre-season. You have #{users_team.budget} left for your next driver:"
end 
    end 




def select_drivers(users_team) 
    driver_one_selection(users_team)
    driver_two_selection(users_team)
    puts "And there it is, the lineup for #{users_team.name} is:"
    puts "#{users_team.drivers[0].first_name} #{users_team.drivers[0].second_name}"
    puts "#{users_team.drivers[1].first_name} #{users_team.drivers[1].second_name}"
end 

def driver_one_selection
  driver1 = game_driver[gets.strip - 1]
  users_team.pick_driver(driver1)
end

def driver_two_selection(users_team)
    driver2_id = gets.strip
    binding pry
    if driver2_id == users_team.drivers[0].id
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




end 