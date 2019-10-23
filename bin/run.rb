require_relative '../config/environment'
require 'pry'

game = Game.create
game.setup_game_data
game.create_team
binding.pry



