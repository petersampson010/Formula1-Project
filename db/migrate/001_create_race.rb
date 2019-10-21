class CreateRace < ActiveRecord::Migration[5.2]

    def change 
        create_table :races do |t|
            t.string :circuit 
            t.string :location 
        end 
    end 
end 