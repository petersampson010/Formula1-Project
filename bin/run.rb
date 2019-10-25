require_relative '../config/environment'
require 'pry'

game = Game.create

game.setup_game_data
game.welcome_screen
game.create_team
game.select_driver
game.select_driver
game.fill_teams
game.present_lineup
game.present_teams
game.wait_for_any_key




# game.show_season_intro_text
# # game.mid_season_changes

races = game.races_in_game
races.each do |race|
  game.create_race_results(race)
  race.show_ranking

  game.show_standing_for_game
  game.show_constructor_standings
  #game.wait_for_any_key
  #game.mid_season_changes
end

game.show_end_season_stats


puts 'eof'


