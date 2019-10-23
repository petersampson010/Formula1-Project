
#Clear all instances
Driver.delete_all
Race.delete_all
Constructor.delete_all
FinishingPosition.delete_all


require_relative '../lib/constructor.rb'
require_relative '../lib/driver.rb'
require_relative '../lib/race.rb'


Constructor.create(name: "Mercedes", nationality: "Germany", tech_factor: 1)
Constructor.create(name: "Ferrari", nationality: "Italy", tech_factor: 0.9)
Constructor.create(name: "Red Bull", nationality: "Austria", tech_factor: 0.8)
Constructor.create(name: "McLaren", nationality: "Britain", tech_factor: 0.6)
Constructor.create(name: "Renault", nationality: "France", tech_factor: 0.6)
Constructor.create(name: "Haas", nationality: "USA", tech_factor: 0.6)
Constructor.create(name: "Toro Rosso", nationality: "Italy", tech_factor: 0.4)
Constructor.create(name: "Alfa Romeo", nationality: "Switzerland", tech_factor: 0.4)


Driver.create(first_name: "Lewis", second_name: "Hamilton", nationality: "Britain", age: 34, constructor_id: 1, price: 10, skill_factor: 10)
Driver.create(first_name: "Valtteri", second_name: "Bottas", nationality: "Iceland", age: 30, constructor_id: 1, price: 7, skill_factor: 7)
Driver.create(first_name: "Sebastian", second_name: "Vettel", nationality: "Germany", age: 32, constructor_id: 2, price: 9, skill_factor: 9)
Driver.create(first_name: "Charles", second_name: "Leclerc", nationality: "France", age: 22, constructor_id: 2, price: 7, skill_factor: 7)
Driver.create(first_name: "Max", second_name: "Verstappen", nationality: "Netherlands", age: 22, constructor_id: 3, price: 8, skill_factor: 8)
Driver.create(first_name: "Alexander", second_name: "Albon", nationality: "Thailand", age: 23, constructor_id: 3, price: 6, skill_factor: 6)
Driver.create(first_name: "Carlos", second_name: "Sainz", nationality: "Spain", age: 25, constructor_id: 4, price: 5, skill_factor: 5)
Driver.create(first_name: "Lando", second_name: "Norris", nationality: "Britain", age: 19, constructor_id: 4, price: 6, skill_factor: 6)
Driver.create(first_name: "Nico", second_name: "Hulkenberg", nationality: "Germany", age: 32, constructor_id: 5, price: 7, skill_factor: 7)
Driver.create(first_name: "Daniel", second_name: "Ricciardo", nationality: "Australia", age: 30, constructor_id: 5, price: 8, skill_factor: 8)
Driver.create(first_name: "Romain", second_name: "Grosjean", nationality: "France", age: 33, constructor_id: 6, price: 5, skill_factor: 5)
Driver.create(first_name: "Kevin", second_name: "Magnussen", nationality: "Denmark", age: 27, constructor_id: 6, price: 6, skill_factor: 6)
Driver.create(first_name: "Daniil", second_name: "Kvyat", nationality: "Russia", age: 25, constructor_id: 7, price: 4, skill_factor: 4)
Driver.create(first_name: "Pierre", second_name: "Gasly", nationality: "France", age: 23, constructor_id: 7, price: 7, skill_factor: 7)
Driver.create(first_name: "Kimi", second_name: "Raikkonen", nationality: "Finland", age: 40, constructor_id: 8, price: 6, skill_factor: 6)
Driver.create(first_name: "Antonio", second_name: "Giovinazzi", nationality: "Italy", age: 25, constructor_id: 8, price: 5, skill_factor: 5)
Driver.create(first_name: "Lance", second_name: "Stroll", nationality: "Canada", age: 20, price: 5, skill_factor: 5)
Driver.create(first_name: "Sergio", second_name: "Perez", nationality: "Mexico", age: 29, price: 5, skill_factor: 5)

Race.create(circuit: "Melbourne Circuit", location: "Melbourne, Australia")
Race.create(circuit: "Bahrain International Circuit", location: "Bahrain")
Race.create(circuit: "Baku City Circuit", location: "Baku, Azerbaijan")
Race.create(circuit: "Circuit de Barcelona-Catalunya", location: "Barcelona, Spain")
Race.create(circuit: "Circuit de Monaco", location: "Monaco")
Race.create(circuit: "Red Bull Ring", location: "Styria, Austria")
Race.create(circuit: "Silverstone Circuit", location: "Towchester, England")
Race.create(circuit: "Hungaroring", location: "Mogyorod, Hungary")
Race.create(circuit: "Marina Bay Street Circuit", location: "Marina Bay, Singapore")
Race.create(circuit: "Suzuka International Racing Course", location: "Suzuka, Japan")

