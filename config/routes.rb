Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :chefs, only: [] do
    resources :dishes, only: [:show], controller: "chef_dishes"
  end
end
