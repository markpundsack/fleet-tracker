FleetTracker::Application.routes.draw do
  match 'fleets/leave' => 'fleets#leave', :as => :leave
  resources :fleets do
    resources :reports
  end
  resources :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  match 'fleets/:id/join' => 'fleets#join', :as => :join
  match 'igb_required' => 'pages#igb_required'
  match 'about' => 'pages#about'
  match 'env' => 'pages#env'
  match 'ping' => 'users#ping'
  match 'users/purge' => 'users#purge', :via => :post
  match 'fleets/:id/purge' => 'fleets#purge', :as => :fleet_purge, :via => :post
  match 'users/:id/tag' => 'tags#create_tag', :as => :create_tag, :via => :post
  match 'users/:id/tag' => 'tags#remove_tag', :as => :remove_tag, :via => :delete
  match 'users/:id/tag' => 'tags#add_tag', :as => :add_tag
  resources :tags do
    get :autocomplete_tag_text, :on => :collection
  end

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "fleets#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
