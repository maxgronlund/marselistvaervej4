Rails_template::Application.routes.draw do





  

  scope "/:locale" do
    resources :blogs, :comments, :companies,:home, :illustrations, :meetingrooms, :newsposts, :pages, :users, 
  end

  
  devise_for :users
 

  get "about/index"
  get "contact/index"
  get 'users/password'
  get "history/index"



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
  
  
  
  resource :locale
  
  
  root :to => "home#index"
  
  scope "/:locale" do
    match "admin" => 'admin#index'
    match "about" => 'about#index'
  end
  match "search" => 'search#index'
  
  
  


end
