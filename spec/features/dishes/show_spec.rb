require 'rails_helper'

# As a visitor
# When I visit a dish's show page
# I see the dish’s name and description
# And I see a list of ingredients for that dish
# and a total calorie count for that dish
# And I see the chef's name.

RSpec.describe 'dishs show page' do
  describe 'As a visitor' do
    describe "When I visit a dish's show page" do
      before :each do
        @chef1 = Chef.create!(name: 'Nigel')
        @dish1 = @chef1.dishes.create!(name: "Steak Dinner", description: "Medium well is best!")
        @ingredient1 = @dish1.ingredients.create!(name: "New York Strip Steak", calories: 800)
        @ingredient2 = @dish1.ingredients.create!(name: "Butter", calories: 200)
        @ingredient3 = @dish1.ingredients.create!(name: "Garlic Cloves", calories: 50)
        visit chef_dish_path(@chef1, @dish1)
      end
      it "I see the dish's name and description" do
        expect(page).to have_content(@dish1.name)
        expect(page).to have_content("Description: #{@dish1.description}")
      end

      it "And I see a list of ingredients for that dish" do
        expect(page).to have_content(@ingredient1.name)
        expect(page).to have_content(@ingredient2.name)
        expect(page).to have_content(@ingredient3.name)
      end

      it "and a total calorie count for that dish" do
        expect(page).to have_content("Calorie Count: 1050")
      end

      it 'And I see the chefs name' do
        expect(page).to have_content("Chef: #{@chef1.name}")
      end
    end
  end
end