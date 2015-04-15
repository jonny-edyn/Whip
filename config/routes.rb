Rails.application.routes.draw do



  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', :registrations => "registrations" }

  resources :users, only: [:edit, :show] do
    collection do
      patch 'update_password'
      get :remove_twitter
      get :remove_facebook
    end
  end

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  resources :issues

  resources :parties

  resources :bills do
    member do
      post :add_issues
    end
  end

  resources :admins do
    collection do
      get :users
      get :bills
      get :parties
      get :issues
      get :constituencies
      post :populate_constituencies
      get :mps
      post :populate_mps
      get :post_codes
    end
  end

  resources :settings, only: [:update]

  resources :relationships, only: [:create, :destroy]

  get '/my_votes' => 'votes#my_votes'
  resources :votes

  root 'static_pages#home'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
