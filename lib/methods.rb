

#METHOD

def new_or_load_game
end 

def list_drivers 
end 

def select_drivers 
end 

def pre_season
    new_or_load_game
    list_drivers
    select_drivers
end



# PREPARE SEASON
#---------------

def introduction 
  puts "Formula1-Fantasy"
  puts "You've just won the lottery! What will you do with it..."
  puts "Build an F1 Team of course!"
  puts "Create your team, pick your drivers and you're ready for the new season ahead"
end 

def create_team 
  puts "Please enter your team name:"
  team_name = gets.strip 
  puts "Please enter the country your team has originated from:"
  team_nationality = gets.strip
  team = Constructor.create(name: team_name, nationality: team_nationality, tech_factor: 0.5)
  team.id
  #users_team = Constructor.find_by(id: 9)
end 

def list_drivers 
  puts `clear`
  puts "Now its time to hire some drivers for your season!" 
  puts "Every drivers desperate to be on your books but watch out, that lottery fund of £100m will only take you so far and once a drivers signed that contract hes in for the season!"
  sleep(2)
  Driver.all.each {|d| puts "#{d.id}. #{d.first_name} #{d.second_name} | Age:#{d.age} | #{d.nationality} | Price:#{d.price}"}
end 

def my_team
  Constructor.find_by(id: 9)
end 

def pick_driver1
  Constructor.find_by(id: team_id).pick_driver
end 

def pick_driver2
  puts "choose your second driver"
  driver2_id = gets.strip 
  driver2 = Driver.find_by(id: driver2_id)
  enough_money?
end 

def select_drivers 
  pick_driver1
  #potentially list_drivers again 
  pick_driver2
end 

def enough_money?
  budget = (14 - driver1.price)
  if driver2.price > budget 
      "You havent got enough for this driver, please select again"
      pick_driver2 
  else 
      puts "And there it is, the lineup for #{users_team} is:"
      puts "#{driver1.id}. #{driver1.first_name} #{driver1.second_name} | #{driver1.age} | #{driver1.nationality} | #{driver1.price}"
      puts "#{driver2.id}. #{driver2.first_name} #{driver2.second_name} | #{driver2.age} | #{driver2.nationality} | #{driver2.price}"
  end 
end 


def new_game 
  introduction 
  team_id = create_team
  list_drivers
  select_drivers
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


# RUN THE SEASON
#----------------

def create_race_results(race)
  race.run_race(Driver.all)
end

def show_driver_ranking(race)
  race.print_ranking(Driver.all)
end

def show_current_driver_standings
  Driver.all.show_standings
end




def prepare_next_race
# options to improve driver/car
# options to see stats on season 
end


def run_season
  # run all races
  Race.all.each do |race|
    create_race_results(race)

    #prepare_for_next_race
    #final_results
  end

end

