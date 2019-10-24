require_relative '../config/environment'
require 'pry'

game = Game.create

game.setup_game_data
game.create_team
game.select_drivers_for_team

game.fill_teams


game.present_lineup

game.mid_season_changes
# binding.pry
# puts 'eof'
