require 'api_constraints'
Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
      scope module: :v1 do
      	resources :users, only: [:show, :create, :update, :destroy, :index] do
      		resources :questions, :only => [:create, :update, :destroy]
          get :questions, on: :member
          get :answers, on: :member
          get :comments, on: :member
          get :favorites, on: :member
          get :newest_questions, on: :member
          get :newest_answers, on: :member
          get :newest_votes, on: :member
          get :tags, on: :member
      	end
      	resources :sessions, :only => [:create, :destroy]
      	resources :questions, :only => [:index, :show] do
      		put :favorite, on: :member
          resources :featured_questions, :only => [:create]
      		delete :unfavorite, on: :member
      		resources :answers, :only => [:create]
      		resources :comments, :only => [:create]
          put  :vote_up, on: :member, controller: :votes, question_id: true
          put  :vote_down, on: :member, controller: :votes, question_id: true
          put  :remove_vote, on: :member, controller: :votes, question_id: true
          resources :edit_suggestions, only: [:create]
          resources :tags, only: [:create, :destroy]
          get :question_tags, on: :member, controller: :tags
          get :no_answers, on: :collection
          get :no_answers_votes, on: :collection
          get :newest_no_answers, on: :collection
          get :votes, on: :member
          get :newest_questions, on: :collection
          get :under_tag, on: :collection
          get :unanswered, on: :collection
          get :newest_unanswered, on: :collection
          get :unanswered_votes, on: :collection
          get :active, on: :collection
          # delete :destroy, controller: :tags, param: :name
      	end

      	resources :answers, :only => [:show, :update] do
      		resources :comments, :only => [:create]
          put  :vote_up, on: :member, controller: :votes, answer_id: true
          put  :vote_down, on: :member, controller: :votes, answer_id: true
          put  :remove_vote, on: :member, controller: :votes, answer_id: true
          put :verify_answer, on: :member
      	end

      	resources :comments, :only => [:show] do
          put :vote_up, on: :member, controller: :votes, comment_id: true
          put :vote_down, on: :member, controller: :votes, comment_id: true
          put :remove_vote, on: :member, controller: :votes, comment_id: true
        end
        resources :votes, :only => [:show]
        resources :featured_questions, only: :show
        resources :edit_suggestions, :only => [:show, :index] do
          put :approve_edit, on: :member
        end
        resources :tags, :only => [:index]

      end 
  end

end