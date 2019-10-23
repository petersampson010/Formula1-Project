

def new_game 
    
    introduction 
    users_team = create_team
    list_drivers
    select_drivers(users_team)
end 

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
    Constructor.create(name: team_name, nationality: team_nationality, tech_factor: 0.5)
end 

def list_drivers 
    puts `clear`
    puts "Now its time to hire some drivers for your season!" 
    puts "Every drivers desperate to be on your books but watch out, that lottery fund of £100m will only take you so far and once a drivers signed that contract hes in for the season!"
    sleep(2)
    Driver.all.each {|d| puts "#{d.id}. #{d.first_name} #{d.second_name} | Age:#{d.age} | #{d.nationality} | Price:#{d.price}"}
end 

def select_drivers(users_team) 
    driver_one_selection(users_team)
    driver_two_selection(users_team)
    puts "And there it is, the lineup for #{users_team.name} is:"
    puts "#{users_team.drivers[0].first_name} #{users_team.drivers[0].second_name}"
    puts "#{users_team.drivers[1].first_name} #{users_team.drivers[1].second_name}"
end 

def driver_one_selection(users_team)
    "please select the number of the driver you'd like to join your team:"
    driver1_id = gets.strip 
    driver1 = Driver.find_by(id: driver1_id)
    users_team.pick_driver(driver1)
    puts "Great choice! #{driver1.first_name} has been on fire pre-season. You have #{users_team.budget} left for your next driver:"
end 

def driver_two_selection(users_team)
    driver2_id = gets.strip 
    driver2 = Driver.find_by(id: driver2_id)
    if enough_money?(users_team, driver2)
        users_team.pick_driver(driver2)
    else 
        puts "You havent got the money for this driver, please select again:"
        driver_two_selection(users_team)
    end 
end 

def enough_money?(users_team, driver)
    if users_team.budget >= driver.price 
        return true 
    else 
        return false 
    end 
end 

def reset_database 
    system("rake db:migrate:reset")
    # system("rake db:rollback")
    # system("rake db:rollback")
    # system("rake db:rollback")
    # system("rake db:rollback")
    # system("rake db:migrate")
    # system("rake db:seed")
end 
