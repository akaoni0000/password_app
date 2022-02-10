Rails.application.routes.draw do
    root "homes#top"
	get "/login" => "homes#user_login"
    resources :users
	post "/users/login" => "users#login"
	post "/users/logout" => "users#logout"
  
end
