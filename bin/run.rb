require_relative '../config/environment'
require 'pry'

game = Game.create

game.setup_game_data
game.create_team
game.select_drivers_for_team


game.present_lineup
binding.pry
puts 'eof'
