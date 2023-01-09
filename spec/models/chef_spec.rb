require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
    it {should have_many(:ingredients).through :dishes}
  end

  describe "instance methods" do
    describe "#unique_ingredients" do
      before :each do
        @chef1 = Chef.create!(name: 'Nigel')
        @dish1 = @chef1.dishes.create!(name: "Steak Dinner", description: "Medium well is best!")
        @ingredient1 = @dish1.ingredients.create!(name: "New York Strip Steak", calories: 800)
        @ingredient2 = @dish1.ingredients.create!(name: "Butter", calories: 200)
        @ingredient3 = @dish1.ingredients.create!(name: "Garlic Cloves", calories: 50)

        @dish2 = @chef1.dishes.create!(name: "King Crab Legs", description: "Wild Alaskan caught crab.")
        @ingredient4 = @dish2.ingredients.create!(name: "Alaskan King Crab Legs", calories: 600)
        @ingredient5 = @dish2.ingredients.create!(name: "Garlic Butter", calories: 300)
        @ingredient6 = @dish2.ingredients.create!(name: "German Wheat Beer", calories: 300)
        @dish2.ingredients << @ingredient3

        @dish3 = Dish.create!(name: "Cereal", description: "Yes, this counts as a dish.")
      end

      it "returns an array of unique ingredients for a chef" do
        expect(@chef1.unique_ingredients).to eq([@ingredient1, @ingredient2, @ingredient3, @ingredient4, @ingredient5, @ingredient6])
      end
    end
  end
end