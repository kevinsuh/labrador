Rails.application.routes.draw do

  get 'relationships/get_relationships'
  get 'occasions/get_occasions'
  get 'cards/get_flavors'

  get 'cards/queue_card'

  get 'sessions/new'

  get 'signup'          => 'users#new'
  post 'waitlist'       => 'users#add_to_waitlist'
  get 'login'           => 'sessions#new'
  post 'login'          => 'sessions#create'
  delete 'logout'       => 'sessions#destroy'
  
  get 'help'            => 'static_pages#help'
  get 'about'           => 'static_pages#about'
  get 'contact_us'      => 'static_pages#contact_us'
  get 'team'            => 'static_pages#team'
  get 'why'             => 'static_pages#why'
  
  get 'test_angular'    => 'static_pages#test_angular'
  
  get 'forgot_password' => 'password_resets#new'
  get 'reset_password'  => 'password_resets#edit'

  # users
  resources :users do
    collection do
      post :validate_basic
      post :validate_address
      post :create_signup
    end

    member do
      
    end
  end

  # cards
  post 'queue_card'    => 'cards#queue_card'
  # get 'get_occasion_types' => 'occasions#get_occasion_types'
  # get 'get_relationship_types' => 'relationships#get_relation_types'
  # get 'get_card_flavor_types' => 'cards#get_card_flavor_types'

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  root 'static_pages#home'







########## SANDBOX ROUTES #########


  # sandbox for flapper_news
  resources :posts, only: [:index, :create, :show] do

    resources :comments, only: [:index, :create, :show] do 
      member do
        put 'upvote' => 'comments#upvote'
      end
    end

    member do
      put 'upvote' => 'posts#upvote'
    end
  end

  
  

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
