Rails.application.routes.draw do

  # checkout subdirectory
  # get 'cart' => 'checkout/orders#view_cart'
  # get 'cart/address' => 'checkout/address#index'
  get 'cart/billing' => 'checkout#confirm_billing'

  namespace :checkout do
    # edit / select addresses
    resources :addresses, only: [:index, :new, :create, :update] do
      collection do
        post 'update_json'
        post 'create_json'
        post 'set_for_order'
        post 'delete'
      end
    end
    # edit / select cards
    resources :payment_cards, only: [:index, :create, :new, :destroy] do
      collection do
        post 'update_card'
        post 'set_for_order'
        post 'update_json'
        post 'create_json'
      end
    end
    # edit / select order
    get '' => 'orders#view_cart'
    get 'final' => 'orders#final_confirmation'
    post 'submit_order' => 'orders#submit_order'
    post 'submit_order_json' => 'orders#submit_order_json'
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
      resources :card_images, only: [:index, :create, :edit, :update, :destroy]
    end
  end

  post 'admin/cards/:card_id/card_images/:id' => "admin/card_images#update_image"


  get 'relationships/get_relationships'
  get 'occasions/get_occasions'

  # cards
  get 'cards/get_flavors'
  post 'cards/get_curated_cards'
  post 'cards/get_cards_for_occasion'

  # queue wizard
  get 'queue_card' => 'cards#queue_wizard'

  # orders
  post 'orders/orders_for_user'
  post 'orders/get_selected_orders'
  post 'orders/queue_card_order'

  # recipients (add/update 'my people')
  get 'recipients/get_current_recipients'
  post 'recipients/create_for_current'
  post 'recipients/update_for_current'
  post 'recipients/delete_for_current'
  post 'recipients/get_recipients'
  post 'recipients/upload_recipient_picture'

  # occasions (add/update 'calendar')
  get 'recipient_occasions/get_occasions_for_current'

  get 'sessions/new'

  get 'signup'          => 'users#new'
  post 'waitlist'       => 'users#add_to_waitlist'
  get 'login'           => 'sessions#new'
  post 'login'          => 'sessions#create'
  delete 'logout'       => 'sessions#destroy'
  get 'logout_angular'  => 'sessions#logout_angular'
  
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
      get :get_current_user
    end

    member do
      
    end
  end

  resources :card_survey_rankings, path: "card_survey" do
    collection do
      post 'submit_survey'
      post 'index'
      get 'index'
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
