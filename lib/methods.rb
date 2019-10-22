
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





def between_race
# options to improve driver/car
# options to see stats on season 
end

def get_ranking(race)
  fps_sorted = FinishingPosition.all.find_by { race.id == race.id }.sort_by { |fp| fp.final_position }
  result = fps_sorted.map { |fp| [fp.final_position, fp.driver] }
# should return an array of arrays [position, driver_name]
end

def return_a_leaderboard
  #
  # 
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
##

def  play_game 
    pre_season
    season
end
