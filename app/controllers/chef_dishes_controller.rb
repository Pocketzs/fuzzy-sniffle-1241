class ChefDishesController < ApplicationController
  def show
    @dish = Dish.find(params[:id])
  end
end