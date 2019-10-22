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



def return_a_leaderboard
#
# 
end

def between_race
# options to improve driver/car
# options to see stats on season 
end

def race_results
# show results
# update points/scores
end



def season

  # iterate through all races
  Race.all.each do |race|
    race.run_race
   #race_results
   #return_as_leaderboard
  end
# return nil
end

## RUN GAME
##================

def  play_game 
    pre_season
    season
end

