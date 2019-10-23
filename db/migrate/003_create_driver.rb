class CreateDriver < ActiveRecord::Migration[5.2]

    def change
        create_table :drivers do |t|
            t.string :first_name
            t.string :second_name
            t.string :nationality
            t.integer :age
            t.string :constructor_id
            t.integer :price
            t.float :skill_factor
            t.integer :game_id
        end 
    end 
end 