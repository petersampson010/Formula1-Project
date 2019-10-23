class CreateConstructor < ActiveRecord::Migration[5.2]

    def change 
        create_table :constructors do |t|
            t.string :name 
            t.string :nationality
            t.float :tech_factor
            t.integer :game_id
            t.integer :budget
        end 
    end 
end 