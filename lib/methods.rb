
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

def earned_points_per_position(position)
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

## RUN THE SEASON

def create_results(race)
  race.run_race(Driver.all)
end

def show_ranking(race)
  race.print_ranking(Driver.all)
end



def prepare_next_race
# options to improve driver/car
# options to see stats on season 
end


def return_a_leaderboard
end

def run_season
  # run all races
  Race.all.each do |race|
    create_results(race)
    prepare_for_next_race
    final_results
  end

end


## RUN GAME
##---------

# def  play_game 
#     pre_season
#     season
# end
