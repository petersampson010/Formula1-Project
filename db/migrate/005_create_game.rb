class CreateGame < ActiveRecord::Migration

    def change 
        create_table :games do |t|
            t.string :users_team 
        end 
    end 
end 

