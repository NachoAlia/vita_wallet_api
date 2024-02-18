Rails.application.routes.draw do 
  namespace :api do
    namespace :v1 do
      get '/', to: 'price#index'
    end 
  end 
end
