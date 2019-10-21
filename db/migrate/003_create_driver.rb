class CreateDriver < ActiveRecord::Migration[5.2]

    def change
        create_table :drivers do |t|
            t.string :first_name
            t.string :second_name
            t.string :nationality
            t.integer :age
        end 
    end 
end 