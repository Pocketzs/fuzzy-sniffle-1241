# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@chef1 = Chef.create!(name: 'Nigel')

@dish1 = @chef1.dishes.create!(name: "Steak Dinner", description: "Medium well is best!")
@ingredient1 = @dish1.ingredients.create!(name: "New York Strip Steak", calories: 800)
@ingredient2 = @dish1.ingredients.create!(name: "Butter", calories: 200)
@ingredient3 = @dish1.ingredients.create!(name: "Garlic Cloves", calories: 50)

@dish2 = @chef1.dishes.create!(name: "King Crab Legs", description: "Wild Alaskan caught crab.")
@ingredient4 = @dish2.ingredients.create!(name: "Alaskan King Crab Legs", calories: 600)
@ingredient5 = @dish2.ingredients.create!(name: "Garlic Butter", calories: 300)
@ingredient6 = @dish2.ingredients.create!(name: "German Wheat Beer", calories: 300)

@dish3 = Dish.create!(name: "Cereal", description: "Yes, this counts as a dish.")
