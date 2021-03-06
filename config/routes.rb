ActionController::Routing::Routes.draw do |map|
  map.resources :subscriptions

  map.resources :me_sections

  map.resources :sections

  map.resources :mes, :has_many => :comments

  map.resources :sessions

  map.resources :users, :member => { :invite => :get }
  
  map.resources :invites
  
  map.connect 'm', :controller => '/m/subscriptions'
  
  map.namespace :m do |m|
    	m.resources :subscriptions
    	m.resources :me_sections
			m.resources :sections
			m.resources :mes, :has_many => :comments
			m.resources :sessions
			m.resources :users
			m.resources :invites
  end

  map.resources :mes, :has_many => :subscribers
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'subscriptions', :action => 'index'
	
  # See how all your routes lay out with "rake routes"
  
  map.connect 'mes/:id/subscribe/:auth', :controller => 'subscriptions', :action => 'new'
  map.connect 'mes/:id/invite', :controller => 'invites', :action => 'new'
  map.connect 'image_search/:query/:format/:start', :controller => 'image_search', :action => 'index'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
