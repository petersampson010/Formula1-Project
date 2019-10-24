require 'pry'

# # PREPARE GAME
# #-------------------
# def create_game_instance
#     Game.create
# end 

# # GAME > PRE-SEASON
# #--------------------
# def start_game(current_game)
#     introduction 
#     users_team = create_team(current_game)
#     list_drivers
#     select_drivers(users_team)
#     Constructor.fill_teams
# end 

# def introduction 
#     puts "Formula1-Fantasy"
#     puts "You've just won the lottery! What will you do with it..."
#     puts "Build an F1 Team of course!"
#     puts "Create your team, pick your drivers and you're ready for the new season ahead"
# end 

# def create_team(current_game)
#     puts "Please enter your team name:"
#     team_name = gets.strip 
#     puts "Please enter the country your team has originated from:"
#     team_nationality = gets.strip
#     current_game.users_team = team_name
#     Constructor.create(name: team_name, nationality: team_nationality, tech_factor: 0.5, budget: 100)
# end 
    

# def list_drivers 
#     puts `clear`
#     puts "Now its time to hire some drivers for your season!" 
#     puts "Every drivers desperate to be on your books but watch out, that lottery fund of £100m will only take you so far and once a drivers signed that contract hes in for the season!"
#     sleep(2)
#     first_drivers = Driver.all.reject {|d| d.id == 17 || d.id == 18}
#     first_drivers.each {|d| puts "#{d.id}. #{d.first_name} #{d.second_name} | Age:#{d.age} | #{d.nationality} | Price:#{d.price}"}
# end 

# def select_drivers(users_team) 
#     driver_one_selection(users_team)
#     driver_two_selection(users_team)
#     puts "And there it is, the lineup for #{users_team.name} is:"
#     puts "#{users_team.drivers[0].first_name} #{users_team.drivers[0].second_name}"
#     puts "#{users_team.drivers[1].first_name} #{users_team.drivers[1].second_name}"
# end 

# def driver_one_selection(users_team)
#     "please select the number of the driver you'd like to join your team:"
#     driver1_id = gets.strip 
#     driver1 = Driver.find_by(id: driver1_id)
#     users_team.pick_driver(driver1)
#     puts "Great choice! #{driver1.first_name} has been on fire pre-season. You have #{users_team.budget} left for your next driver:"
# # end 

# def driver_two_selection(users_team)
#     driver2_id = gets.strip
#     binding pry
#     if driver2_id == users_team.drivers[0].id
#         puts "You cant select the same driver twice!, please try again"
#         driver_two_selection(users_team)
#     else 
#         driver2 = Driver.find_by(id: driver2_id)
#         if enough_money?(users_team, driver2)
#             users_team.pick_driver(driver2)
#         else 
#             puts "You havent got the money for this driver, please select again:"
#             driver_two_selection(users_team)
#         end 
#     end 
# end 

# def enough_money?(users_team, driver)
#     if users_team.budget >= driver.price 
#         return true 
#     else 
#         return false 
#     end 
# end 




# GAME > RUNNING THE SEASON
#--------------------------



# def create_race_results(race)
#   race.run_race(Driver.all)
# end

# def show_race_ranking(race)
#   race.show_ranking(Driver.all)
# end

def show_current_driver_standings
  Driver.all.show_standings
end

def credits_earned_driver(id_race, id_driver)
  fp = FinishingPosition.find_by(driver_id: id_driver,race_id: id_race)
  credits_per_position(fp..final_position)
end

def credits_earned_team(race_id, team_id)
  Constructor.find_by(id: team_id).drivers.each do |driver|
    credits_earned_driver(race_id, driver.id)
  end
end

def update_budget(race_id, team_id)
  current_game.budegt += earned_credits_team(race_id, team_id)
end


def train_driver

end

def improve_car

end

def upgrade_team(current_game)
  total_budget = current_game.budget # should be derived from Game
  
  puts "You have now total budget of #{total_budget}"
  puts 'Do you want to upgrade your team? Y-N'

  #if yes

  puts "upgrade car or train driver?"

    #if car
    improve_car
    #elseif driver
    train_driver

  #else
  #end

end




#GAME LOGIC
#-------------------------

def new_game 

    current_game = create_game_instance
    start_game(current_game)


  ## prep game
 ##--------------
  
  #upgrade_team(current_game)

  ## pre-season
  ##--------------

  ## season-run

     Race.all.each do |current_race|
      create_race_results(current_race)
      show_race_ranking(current_race)
      puts "rankings"
      wait_for_any_key
      show_current_driver_standings
      puts "standings"
      wait_for_any_key
  #    upgrade_team
  #    wait_for_any_key
    end


end 

