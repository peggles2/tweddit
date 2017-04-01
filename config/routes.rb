Rails.application.routes.draw do
  root to: "tweet#index"
  devise_for :user  
  resources :tweet
  match "/tweet/create_comment", :to => "tweet#create_comment", :via => [:post]
  match "/tweet/vote/:selection/:id",         :to => "tweet#vote", :via => [:post]
end
