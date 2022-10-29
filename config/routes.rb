Rails.application.routes.draw do
  resources :weathericons
  resources :images
  resources :users
  resources :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  
  get 'logout', to:'api#logout', as:'logout'
  get 'getWeatherIcons', to:'api#getWeatherIcons', as:'getWeatherIcons'
  get 'getImagesUploaded', to:'api#getImagesUploaded', as:'getImagesUploaded'
  post 'uploadImageByUser', to:'api#uploadImageByUser', as:'uploadImageByUser'
  post 'login', to:'api#login', as:'login'
  post 'updateUserToken', to:'api#updateUserToken', as:'updateUserToken'
  post 'registerUser', to:'api#registerUser', as:'registerUser'
  post 'updateUserData', to:'api#updateUserData', as:'updateUserData'
  post 'getUserData', to:'api#getUserData', as:'getUserData'
  post 'updateUserLatLong', to:'api#updateUserLatLong', as:'updateUserLatLong'
  root to: 'users#index'
  

end
