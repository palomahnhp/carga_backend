Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get '/admin_panel', to: 'welcome#admin_panel'
  get '/settings', to: 'welcome#settings'
  get '/tracking', to: 'welcome#tracking'
  get '/send_mail', to: 'welcome#send_mail'
  get '/show_mail', to: 'welcome#show_mail'

  get '/functions', to: 'functions#index'
  get '/functions/delete', to: 'functions#delete'
  get '/functions/new', to: 'functions#new'

  get '/positions', to: 'positions#index'
  get '/positions/delete', to: 'positions#delete'
  get '/positions/new', to: 'positions#new'

  get '/units', to: 'units#index'
  get '/units/delete', to: 'units#delete'
  get '/units/new', to: 'units#new'

  get '/surveys', to: 'surveys#index'
  get '/surveys/show', to: 'surveys#show'

  get '/campaigns', to: 'campaigns#index'
  get '/campaigns/delete', to: 'campaigns#delete'
  get '/campaigns/new', to: 'campaigns#new'


  post '/functions/update', to: 'functions#update'
  post '/functions/create', to: 'functions#create'

  post '/positions/update', to: 'positions#update'
  post '/positions/create', to: 'positions#create'

  post '/units/update', to: 'units#update'
  post '/units/create', to: 'units#create'

  post '/surveys/submit_survey', to: 'surveys#submit_survey'

  post '/campaigns/update', to: 'campaigns#update'
  post '/campaigns/create', to: 'campaigns#create'


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
