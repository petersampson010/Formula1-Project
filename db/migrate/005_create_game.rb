class CreateGame < ActiveRecord::Migration[5.2]

    def change 
        create_table :games do |t|
            t.string :users_team 
        end 
    end 
end 

