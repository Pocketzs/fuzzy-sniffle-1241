require 'rails_helper'
# As a visitor
# When I visit a chef's show page
# I see the name of that chef
# and I see a list of all dishes that belong to that chef
# and I see a form to add an existing dish to that chef
# When I fill in the form with the ID of a dish that exists in the database
# And I click Submit
# Then I am redirected to that chef's show page
# And I see the dish is now listed. 

# As a visitor
# When I visit a chef's show page
# I see a link to view a list of all ingredients that this chef uses in their dishes.
# When I click on that link
# I'm taken to a chef's ingredients index page
# and I can see a unique list of names of all the ingredients that this chef uses.

RSpec.describe "chef's show page" do
  describe "As a visitor" do
    describe "When I visit a chef's show page" do
      before :each do
        @chef1 = Chef.create!(name: 'Nigel')
        @dish1 = @chef1.dishes.create!(name: "Steak Dinner", description: "Medium well is best!")
        @ingredient1 = @dish1.ingredients.create!(name: "New York Strip Steak", calories: 800)
        @ingredient2 = @dish1.ingredients.create!(name: "Butter", calories: 200)
        @ingredient3 = @dish1.ingredients.create!(name: "Garlic Cloves", calories: 50)

        @dish2 = @chef1.dishes.create!(name: "King Crab Legs", description: "Wild Alaskan caught crab.")
        @ingredient4 = @dish2.ingredients.create!(name: "Alaskan King Crab Legs", calories: 600)
        @ingredient5 = @dish2.ingredients.create!(name: "Garlic Sauce", calories: 300)
        @ingredient6 = @dish2.ingredients.create!(name: "German Wheat Beer", calories: 300)
        @dish2.ingredients << @ingredient3

        @dish3 = Dish.create!(name: "Cereal", description: "Yes, this counts as a dish.")

        visit chef_path(@chef1)
      end
      it 'I see the name of that chef' do
        expect(page).to have_content(@chef1.name)
      end

      it "And I see a list of all dishes that belong to that chef" do
        within "#dishes" do
          expect(page).to have_content(@dish1.name)
          expect(page).to have_content(@dish2.name)
          expect(page).to_not have_content(@dish3.name)
        end
      end

      it "And I see a form to add an existing dish to that chef" do
        expect(page).to have_field(:dish_id)
        expect(page).to have_button("Add Dish")
      end

      describe "When I fill in the form with the ID of a dish that exists in the database and I click submit" do
        before :each do
          fill_in(:dish_id, with: @dish3.id)
          click_button("Add Dish")
        end
        it "Then I am redirected to that chef's show page" do
          expect(current_path).to eq(chef_path(@chef1))
        end

        it "And I see the dish is now listed" do
          within "#dishes" do
            expect(page).to have_content(@dish1.name)
            expect(page).to have_content(@dish2.name)
            expect(page).to have_content(@dish3.name)
          end
        end
      end

      it "I see a link to view a list of all ingredients that this chef uses in their dishes." do
        expect(page).to have_link("Chef #{@chef1.name}'s Ingredients")
      end

      describe "When I click on that link" do
        before :each do
          click_link("Chef #{@chef1.name}'s Ingredients")
        end
        it "I'm taken to a chef's ingredients index page" do
          expect(current_path).to eq(chef_ingredients_path(@chef1))
        end

        it "and I can see a unique list of names of all the ingredients that this chef uses." do
          expect(@dish1.ingredients).to include(@ingredient3)
          expect(@dish2.ingredients).to include(@ingredient3)
          
          expect(page).to have_content(@ingredient1.name, count: 1)
          expect(page).to have_content(@ingredient2.name, count: 1)
          expect(page).to have_content(@ingredient3.name, count: 1)
          expect(page).to have_content(@ingredient4.name, count: 1)
          expect(page).to have_content(@ingredient5.name, count: 1)
          expect(page).to have_content(@ingredient6.name, count: 1)
        end
      end
    end
  end  
end