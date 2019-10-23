class CreateRace < ActiveRecord::Migration[5.2]

    def change 
        create_table :races do |t|
            t.string :circuit 
            t.string :location 
            t.integer :game_id
        end 
    end 
end 