class Race < ActiveRecord::Base

  has_many :drivers, through: :finishing_positions
  has_many :finishing_positions

  def run_race(drivers, race)
    # call function to create scoreboard, sort it, create FinishingPositions
    sorted_sb = create_drivers_scoreboard(drivers).sort { |a, b| a[0] <=> b[0] }
    sorted_sb.each_with_index do |scorecard, index|
    fp = FinishingPosition.create(final_position: index + 1, driver_id: scorecard[1].id, race_id: race.id)
    race.finishing_positions << fp
    end
 end

end 
