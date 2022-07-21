Rails.application.routes.draw do
  resources :api_keys
  devise_for :users
  root 'home#index'
  # get '/word', to: 'user_word#getAWord'
  # get '/example', to: 'user_word#getAExample'
  # resources :user_words
  get '/word', to: 'user_word#getAWord'
  get '/definition', to: 'user_word#getADefinition'
  get '/example', to: 'user_word#getAExample'
  get '/synonym', to: 'user_word#getSynonym'
  get '/antonym', to: 'user_word#getAntonym'
  match '*unmatched', to: 'application#route_not_found', via: :all

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
