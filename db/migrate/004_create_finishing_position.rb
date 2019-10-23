class CreateFinishingPosition < ActiveRecord::Migration[5.2]

    def change 
        create_table :finishing_positions do |t|
            t.integer :final_position
            t.integer :race_id
            t.integer :driver_id
            t.integer :game_id
        end 
    end 
end 
