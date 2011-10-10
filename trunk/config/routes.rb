ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  #map.register '/register', :controller => 'users', :action => 'create' #MSP / KIPS TODO Remove when LIVE
  #map.signup '/signup', :controller => 'users', :action => 'new'

  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil


  map.resources :users

  map.resource :session

  map.resources :messages

  map.resources :projects

  map.resources :news, :controller => :news_items
  map.resources :news_items

  map.stockists "/stockists", :controller => "stockists", :action => "index"

  map.show_news "/news/:id/:headline", :controller => "news_items", :action => "show"
  map.show_project "/projects/:id/:title", :controller => "projects", :action => "show"

  map.home "/home", :controller => "static_content", :action => "home"
  map.heritage "/heritage", :controller => "static_content", :action => "heritage"
## pjd 
  map.about_history "/heritage/history", :controller => "static_content", :action => "history"
  map.about_production "/heritage/production", :controller => "static_content", :action => "production"
  map.about_media "/heritage/media", :controller => "static_content", :action => "media"
  map.about_film "/heritage/film", :controller => "static_content", :action => "film"
  map.faq "/faq", :controller => "static_content", :action => "faq"
  map.contact "/contact", :controller => "static_content", :action => "contact"
  map.legal "/legal", :controller => "static_content", :action => "legal"
  map.telephone "/telephone", :controller => "static_content", :action => "telephone"
# pjd colors etc
  map.standard "/standard", :controller => "static_content", :action => "standard"
  map.naturals "/naturals", :controller => "static_content", :action => "naturals"
  map.loomtex "/loomtex", :controller => "static_content", :action => "loomtex"
  map.outdoor "/outdoor", :controller => "static_content", :action => "outdoor"
  map.other "/farrow-and-ball", :controller => "static_content", :action => "farrow_and_ball"
  map.fabric "/fabric", :controller => "static_content", :action => "fabric"
  map.accessories "/accessories", :controller => "static_content", :action => "accessories"
  map.brochure "/brochure", :controller => "messages", :action => "brochure_request"
  map.brochure "/contact_us", :controller => "messages", :action => "contact_us"


  map.search "/contact", :controller => "static_content", :action => "contact"
  map.search "/search", :controller => "search", :action => "index"

  map.stockist_search "/stockist_search", :controller => "stockists", :action => "search"

#  map.browse "/browse/:range/:category_kind/:category/:product_id", :controller => "browse", :action => "index"
  map.browse_category "/products/:category_kind/:category", :controller => "products", :action => "index"
  map.browse_category_selected "/products/:category_kind/:category/:selected_id", :controller => "products", :action => "index"
  map.browse_category_product "/products/:category_kind/:category/:id/:product", :controller => "products", :action => "index"
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

  map.admin "/admin", :controller => "admin/route", :action => "index"
  
  # Sample resource route within a namespace:
     map.namespace :admin do |admin|
       # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
       admin.resources :products
       admin.resources :product_attribute_fields
       admin.resources :product_ranges
       admin.resources :taggings
       admin.resources :categories, :controller => "tags"
       admin.resources :tags
       admin.resources :weaves
       admin.resources :stockists
       admin.resources :assets
     end

  map.connect "sitemap.xml", :controller => "sitemap", :action => "sitemap"

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   map.root :controller => "static_content", :action => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
