Rails.application.routes.draw do 
  namespace :api do
    namespace :v1 do
      get '/', to: 'price#index'

      post '/signup', to: 'users#create'
      post '/login', to: 'sessions#create'
      post '/logout', to: 'sessions#destroy'

      post '/purchase', to: 'transactions#purchase'
      post '/sale', to: 'transactions#sale'
      post '/deposit', to: 'transactions#deposit'

      get '/users/:user_id/transactions', to: 'transactions#list_transactions'
      get 'transactions/:id', to: 'transactions#show'
    end 
  end 
end
