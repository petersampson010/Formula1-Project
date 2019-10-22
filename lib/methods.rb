
def new_game 
    introduction 
    create_team
    list_drivers
    select_drivers
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
    users_team = Constructor.find_by(id: 9)
end 

def list_drivers 
    puts `clear`
    puts "Now its time to hire some drivers for your season!" 
    puts "Every drivers desperate to be on your books but watch out, that lottery fund of £100m will only take you so far and once a drivers signed that contract hes in for the season!"
    sleep(2)
    Driver.all.each {|d| puts "#{d.id}. #{d.first_name} #{d.second_name} | Age:#{d.age} | #{d.nationality} | Price:#{d.price}"}
end 

def pick_driver1
    puts "Take a look through all the drivers and select one by entering their number:"
    driver1_id = gets.strip 
    driver1 = Driver.find_by(id: driver1_id)
    puts "Great choice, #{driver1.first_name} has been on fire pre-season! You now have #{14 - driver1.price} to spend on your second driver"
    driver1
end 

def pick_driver2
    driver2_id = gets.strip 
    driver2 = Driver.find_by(id: driver2_id)
    driver_one = pick_driver1
    budget = (14 - driver_one.price)
    if driver2.price > budget 
        "You havent got enough for this driver, please select again"
        pick_driver2 
    else 
        puts "And there it is, the lineup for #{users_team} is:"
        puts "#{driver1.id}. #{driver1.first_name} #{driver1.second_name} | #{driver1.age} | #{driver1.nationality} | #{driver1.price}"
        puts "#{driver2.id}. #{driver2.first_name} #{driver2.second_name} | #{driver2.age} | #{driver2.nationality} | #{driver2.price}"
    end 
end 



def select_drivers 
    pick_driver1
    #potentially list_drivers again 
    pick_driver2
end 

def enough_money?
    budget = (14 - pick_driver1.price)
    if driver2.price > budget 
        "You havent got enough for this driver, please select again"
        pick_driver2 
    else 
        puts "And there it is, the lineup for #{users_team} is:"
        puts "#{driver1.id}. #{driver1.first_name} #{driver1.second_name} | #{driver1.age} | #{driver1.nationality} | #{driver1.price}"
        puts "#{driver2.id}. #{driver2.first_name} #{driver2.second_name} | #{driver2.age} | #{driver2.nationality} | #{driver2.price}"
    end 
end 


