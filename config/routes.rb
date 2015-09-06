Rails.application.routes.draw do

  # checkout subdirectory
  # get 'cart' => 'checkout/orders#view_cart'
  # get 'cart/address' => 'checkout/address#index'
  get 'cart/billing' => 'checkout#confirm_billing'

  namespace :checkout do
    get '/' => 'orders#view_cart'
    resources :addresses, only: [:index, :new, :create, :update] do
      collection do
        post 'set_for_order'
        post 'delete'
      end
    end
    # checkout / credit card
    resources :charges, only: [:new, :create]
  end

  # admin
  get 'admin' => 'admin#home'
  namespace :admin do
    # build on these as you continue
    resources :users, only: [:index]
    resources :cards, only: [:new, :create, :destroy, :update] do
      collection do
        post 'index'
        get 'index'
      end
    end
  end


  get 'relationships/get_relationships'
  get 'occasions/get_occasions'

  # cards
  get 'cards/get_flavors'
  post 'cards/get_curated_cards'

  # orders
  post 'orders/orders_for_user'
  post 'orders/queue_card_order'

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
      get :current_user_info
    end

    member do
      
    end
  end

  
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
