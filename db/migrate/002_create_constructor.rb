class CreateConstructor < ActiveRecord::Migration[5.2]

    def change 
        create_table :constructors do |t|
            t.string :name 
            t.string :nationality 
            t.integer :driver_one_id
            t.integer :driver_two_id
        end 
    end 
end 