Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/login', to: 'auth#login'
  get '/health', to: 'health#health'

  resources :posts, only: %i[index show create update]
end
