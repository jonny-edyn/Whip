Rails.application.routes.draw do
  

  authenticated :user do
   root :to => 'bills#index', :as => :authenticated_root
  end
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', :sessions => "sessions", :registrations => "registrations" }


  get '/following' => 'users#following'
  get '/followers' => 'users#followers'
  resources :users, only: [:edit, :show] do
    collection do
      patch :update_info
      get :remove_twitter
      get :remove_facebook
      post :send_mp_notification_fb
      post :send_mp_notification_tw
      post :send_mp_email
      post :accepted_terms
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


  resources :bills

  namespace :admin do
    resources :bills, only: [:index, :edit, :update, :destroy] do
      collection do
        get :voting_results
        post :get_voting_results
        post :mass_bill_import
      end
      member do
        post :add_issues
      end
    end
    resources :constituencies, only: [:index] do
      collection do
        post :populate_constituencies
      end
    end
    resources :issues, only: [:index, :create, :update, :destroy]
    resources :mps, only: [:index] do
      collection do
        post :populate_mps
        post :mass_mp_import
      end
    end
    resources :parties, only: [:index, :create, :update, :destroy]
    resources :users, only: [:index]
  end


  resources :settings, only: [:update]


  resources :relationships, only: [:create, :destroy]


  get '/my_votes' => 'votes#my_votes'
  resources :votes do
    member do
      patch :upvote
      patch :change_vote_comment
    end
  end


  resources :media_links


  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all


  get '/privacy' => 'static_pages#privacy'
  get '/terms' => 'static_pages#terms'
  get '/contact' => 'static_pages#contact'
  get '/about' => 'static_pages#about'
  get '/jobs' => 'static_pages#jobs'
  get '/guidelines' => 'static_pages#guidelines'
  get '/feedback' => 'static_pages#feedback'


  post 'mailing_list_request' => 'static_pages#mailing_list_request'
  root 'bills#index'

end
