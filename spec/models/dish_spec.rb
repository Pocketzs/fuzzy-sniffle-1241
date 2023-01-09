require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
  end
  describe "relationships" do
    it { should belong_to(:chef).optional }
    it { should have_many :dish_ingredients }
    it { should have_many(:ingredients).through :dish_ingredients }
  end

  describe "instance methods" do
    describe "#total_calorie_count" do
      before :each do
        @chef1 = Chef.create!(name: 'Nigel')
        @dish1 = @chef1.dishes.create!(name: "Steak Dinner", description: "Medium well is best!")
        @ingredient1 = @dish1.ingredients.create!(name: "New York Strip Steak", calories: 800)
        @ingredient2 = @dish1.ingredients.create!(name: "Butter", calories: 200)
        @ingredient3 = @dish1.ingredients.create!(name: "Garlic Cloves", calories: 50)
      end
      it "returns the sum total of all a dish's calories from all ingredients" do
        expect(@dish1.total_calorie_count).to eq(1050)
      end
    end
  end
end