Rails.application.routes.draw do
  
  # get request
  # url "/hello"
  # WelcomeController
  # action is to call welcome_controller.index
  get "/hello" => "welcome#index"
  
  get "/contact" => "contact#index"
  post "/contact" => "contact#create"
  
  # The url helper willl be whateveer you put appended with _path or _url.
  # When linking internally, you can use either,pref _path
  # When providing a link externally (such as in an email) you must use URL
  get "/hello/:name" => "welcome#hello", as: :greet # use a helper called 'greet_path'
  get "/hello/:name/:city" => "welcome#hello", as: :full_greeting # use a helper called 'greet_path'
  
  
  get "/subscribe" => "subscribe#index"
  post "/subscribe" => "subscribe#subscribe"
  # This sets the home page.  The helpers are:  root_path and root_url
  root "welcome#index"
  
  
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
