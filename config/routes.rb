Rails.application.routes.draw do 
  namespace :api do
    namespace :v1 do
      get '/get_btc_price', to: 'price#get_btc_price'
    end 
  end 
end
