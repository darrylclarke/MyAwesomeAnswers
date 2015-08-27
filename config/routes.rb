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
  
  
  
  
  # resources :questions #A1
  # post "/questions/:question_id/answers" => "answers#create" #A2
  
  #or B:
  resources :questions  do
    #nesting resources :answers in here makes every URL for answers prepended
    # with/questions/:question_id
    resources :answers, only: [:create, :destroy]
 
  end
  
  resources :answers, only: [] do
    resources :comments, only: [:create, :destroy] 
  end
  
  resources :users, only: [:new, :create]
  
  resources :sessions, only: [:new, :create] do
    # this will crete for us a route with DELETE http verb and /sessions#
    # adding the on: :collection option will make it part of the routes for 
    # sessions, which means it won't prepend the routes with /sessions/:session_id
    delete :destroy, on: :collection
  end
  
 #sessions_path	    DELETE	/sessions(.:format)	sessions#destroy
 #                  POST	  /sessions(.:format)	sessions#create
 #new_session_path	GET	    /sessions/new(.:format)	sessions#new
 
  patch "/question/:id/lock" => "questions#lock", as: :lock_question
  
  # get  "/questions/new"          => "questions#new",    as: :new_question   # 2015.08.20  (as new_question_path)
  # post "/questions"              => "questions#create", as: :questions      # Convention has path plural here.
  # get  "/questions/:id"          => "questions#show",   as: :question       # 2015.08.20 Singular helper
  #                                                                           # more specific URLs have to go first.
  # get  "/questions"              => "questions#index" # No need for helper as it is defined above. :questions 
  # get  "/questions/:id/edit"     => "questions#edit",   as: :edit_question  # This of course goes last.
  # patch "/questions/:id"         => "questions#update"                                                        
  # delete "/questions/:id"        => "questions#destroy"
  
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
