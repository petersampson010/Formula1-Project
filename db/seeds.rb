#Clear all instances
Driver.delete_all
Race.delete_all
Constructor.delete_all
FinishingPosition.delete_all

#seed constructors
#:id :name :nationality :driver_one_id :driver_two_id

team_one   = Constructor.create(name: "Ferrari", nationality: "Italy", tech_factor: 1)
team_two   = Constructor.create(name: "McLaren", nationality: "UK",  tech_factor: 1)
#team_three = Constructor.create(name: "Mercedes", nationality: "Germany")
#team_four  = Constructor.create(name: "Willimans", nationality: "TBC")

#seed drivers
#id :first_name :second_name :nationality :age

driver_one   = Driver.create(first_name: "Mike",    second_name: "Mueller",   nationality: "Germany", age: 32, price: 100, skill_factor: 1)
driver_two   = Driver.create(first_name: "John",    second_name: "Mueller",   nationality: "Germany", age: 33, price: 100, skill_factor: 1)
driver_three = Driver.create(first_name: "Steven",  second_name: "Stevenson", nationality: "Sweden",  age: 32, price: 100, skill_factor: 1)
driver_four  = Driver.create(first_name: "Tom",     second_name: "Tompson",   nationality: "UK",      age: 29, price: 100, skill_factor: 1)

#assign drivers to teams
driver_one.constructor = team_one
driver_two.constructor = team_one

team_one.drivers << driver_one
team_one.drivers << driver_two

driver_three.constructor = team_two
driver_four.constructor = team_two

team_two.drivers << driver_three
team_two.drivers << driver_four

#seed races
#:id :circuit :location
race_one   = Race.create(circuit: "Silverstone",    location: "UK")
race_two   = Race.create(circuit: "Nurburg Ring",   location: "Germany")
#race_three = Race.create(circuit: "Circuit de Monaco", location: "Monaco")
#race_four  = Race.create(circuit: "Suzuka Circuit", location: "Japan")

#results
#:final_position :race_id :driver_id
fp_1 = FinishingPosition.create(final_position: 1, race_id: 1, driver_id: 1)
fp_2 = FinishingPosition.create(final_position: 2, race_id: 1, driver_id: 2)
fp_3 = FinishingPosition.create(final_position: 3, race_id: 1, driver_id: 3)
fp_4 = FinishingPosition.create(final_position: 4, race_id: 1, driver_id: 4)

fp_5 = FinishingPosition.create(final_position: 1, race_id: 2, driver_id: 4)
fp_6 = FinishingPosition.create(final_position: 2, race_id: 2, driver_id: 3)
fp_7 = FinishingPosition.create(final_position: 3, race_id: 2, driver_id: 2)
fp_8 = FinishingPosition.create(final_position: 4, race_id: 2, driver_id: 1)