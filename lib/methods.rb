def new_or_load
    puts "Press N for new game or L for load previous"
    users_input = gets.strip
    if users_input == 'n' || 'N'
        new_game 
    elsif users_input == 'l' || 'L'
        load_game 
    else 
        new_or_load
    end 
end

def new_game 
    puts "Introduction and explanation of game and how they can select/improve their team, also how they can get help if needed"
    puts "please enter your team name"
    team_name = gets.strip
    **POTENTIAL TO CHANGE NAME IF TEHY MISSPELL**
    puts "please enter your team nationality"
    team_nationality = gets.strip 
    team_name = Constructor.new????create(name: team_name, nationality: team_nationality, tech_factor: 0.1)
    puts "now its time to pick your drivers!"
    list_drivers
    select_drivers 
    puts "take a look through all the drivers and select two by entering their number: Be careful though, your a new team so only have a starting budget of £100"
    puts 
end 



def list_drivers 
    Driver.all.map {|d| puts "#{driver.id}. #{driver.first_name} #{driver.second_name} | #{driver.age} | #{driver.nationality} | #{driver.price}"}
end 

def select_drivers 
    puts "take a look through all the drivers and select two by entering their number: Be careful though, your a new team so only have a starting budget of £100"
    puts "driver1:"
    driver1_id = gets.strip 
#what happens if input is invalid 
    driver1 = Driver.find_by(id: driver1_id)
    puts "you have selected #{driver1.name}"
    puts "driver2:"
    driver2_id = gets.strip
    driver2 = Driver.find_by(id: driver2_id)

