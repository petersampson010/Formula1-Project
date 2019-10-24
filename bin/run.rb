require_relative '../config/environment'
require 'pry'

game = Game.create

game.setup_game_data
game.create_team
game.testing_select_driver
game.testing_select_driver 
game.present_lineup




# game.show_season_intro_text
# # game.mid_season_changes

races = game.races_in_game
races.each do |race|
  game.create_race_results(race)
  race.show_ranking
    game.show_standing_for_game
#    game.wait_for_any_key
   game.mid_season_changes
end

require 'pry'
binding.pry



puts 'eof'

# game.show_season_intro_text
# race = game.races_in_game[0]



# game.select_drivers_for_team
# game.fill_teams

# game.present_lineup

# # game.mid_season_changes
# game.show_season_intro_text

# race = game.races_in_game[0]
# game.create_race_results(race)
# game.show_race_result_text
# game.show_race_ranking(race)
# #game.wait_for_any_key
# game.show_standing_for_game
# binding.pry
# puts 'eof'



# # binding.pry
# # puts 'eof'
