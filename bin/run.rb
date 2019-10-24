require_relative '../config/environment'
require 'pry'

game = Game.create

game.setup_game_data
game.create_team
game.select_drivers_for_team
game.fill_teams

game.present_lineup

# game.mid_season_changes
game.show_season_intro_text

race = game.races_in_game[0]
game.create_race_results(race)
game.show_race_result_text
game.show_race_ranking(race)
#game.wait_for_any_key
game.show_standing_for_game
binding.pry
puts 'eof'



# binding.pry
# puts 'eof'
