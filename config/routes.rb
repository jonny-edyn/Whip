Rails.application.routes.draw do

  authenticated :user do
    root :to => 'bills#index', :as => :authenticated_root
  end


  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', :registrations => "registrations" }

  resources :users, only: [:edit, :show] do
    collection do
      patch 'update_password'
      get :remove_twitter
      get :remove_facebook
    end
    member do
      post :add_post_code_join_constituency
      post :add_user_to_party
    end
  end

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  match '/issues/:issue_name/' => 'issues#find_issues', via: [:get], :as => :issue_name
  resources :issues

  resources :parties

  resources :bills do
    member do
      post :add_issues
    end
    collection do
      get :xls_index
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
      get :voting_results
      post :get_voting_results
      post :mass_bill_import
    end
  end

  resources :settings, only: [:update]

  resources :relationships, only: [:create, :destroy]

  get '/my_votes' => 'votes#my_votes'
  resources :votes

  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

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
