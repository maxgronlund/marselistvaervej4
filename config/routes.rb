Rails_template::Application.routes.draw do


  get "mail_all/index"

  resources :admin_galleries do
    resources :photos
  end
  
  resources :galleries
  resources :galleries do
    resources :photos
  end
  resources :photos
  resources :info_pages

  resources :company_thumbs

  scope "/:locale" do
    resources :bookings, 
              :blogs, 
              :comments, 
              :companies,
              :home, 
              :illustrations, 
              :meetingrooms, 
              :newsposts, 
              :pages,
              :photos, 
              :users, 
              :show_all_company
  end

  
  devise_for :users
 

  get "about/index"
  get "contact/index"
  get 'users/password'
  get "history/index"
  get "googlemap/index"
  get "bookingcalendar/index"
  get "week_plan/index"
  get "house_rules/index"
  get "info/index"
#  get "admin_images/index"
  get "all_history/index"
  
  scope "/:locale" do
    resources :users do
      member do
        get :recrop
      end
      resources :blogs
      resources :blogs do
        resources :comments
      end
      resources :comments
    end
  end 
  
  resources :blogs do
    resources :comments
  end
  
  resources :meetingrooms do
    resources :bookings
  end
  
  resources :companies do
    resources :company_thumbs
  end
  
  
  
  resource :locale
  
  
  root :to => "home#index"
  
  scope "/:locale" do
    match "admin" => 'admin#index'
    match "about" => 'about#index'
  end
  match "search" => 'search#index'
  
  
  


end
