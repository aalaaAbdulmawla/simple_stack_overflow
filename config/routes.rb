require 'api_constraints'
Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
      scope module: :v1 do
      	resources :users, only: [:show, :create, :update, :destroy, :index] do
      		resources :questions, :only => [:create, :update, :destroy]
      	end
      	resources :sessions, :only => [:create, :destroy]
      	resources :questions, :only => [:index, :show] do
      		put :favorite, on: :member
      		delete :unfavorite, on: :member
      		resources :answers, :only => [:create]
      	end

      	resources :answers, :only => [:show]
      end 
  end

end