ActionController::Routing::Routes.draw do |map|
  #  map.resources :users
  map.resources :users, :has_many => :vehicles, :member => { :suspend   => :put,
                                                             :unsuspend => :put,
                                                             :purge     => :delete } do |users|
    users.resources :vehicles, :has_many => :fill_ups
  end
  
  map.resource :session

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil

  map.import_fill_ups '/users/:user_id/vehicles/:vehicle_id/fill_ups/import', :controller => 'fill_ups', :action => 'import'
  map.upload_fill_ups '/users/:user_id/vehicles/:vehicle_id/fill_ups/upload', :controller => 'fill_ups', :action => 'upload'

  map.mpg_chart '/users/:user_id/vehicles/:vehicle_id/charts/mpg_chart', :controller => "charts", :action => "mpg_chart_code"
  map.cpg_chart '/users/:user_id/vehicles/:vehicle_id/charts/cpg_chart', :controller => "charts", :action => "cpg_chart_code"
  map.cpm_chart '/users/:user_id/vehicles/:vehicle_id/charts/cpm_chart', :controller => "charts", :action => "cpm_chart_code"

  # map.resources :vehicles, :has_many => :fill_ups

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
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'vehicles' 
  
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
