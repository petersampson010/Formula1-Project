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
    team_name = Constructor.new(name: team_name, nationality: team_nationality, tech_factor: 0.1)
    puts "now its time to pick your drivers!"
    list_drivers 



end 



def list_drivers 
    Driver.all.map {|d| puts "#{driver.id}. #{driver.first_name} #{second_name} | {"}
