Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase


  #@ USER ROUTES###########################
  get '/login' => 'session#login'
  get '/logout' => 'session#logout'
  post '/login' => 'session#login'
  get '/registration' => 'user#registration'
  post '/registration' => 'user#registration'
  get 'user/token/' => 'user#token'
  get 'user/profile/' => 'user#profile'
  resource :user
  ##########################################

  #@ADMIN ROUTES############################
  get 'crm/groups/' => 'admin#groups_index'
  get 'crm/groups/create' => 'admin#groups_create'
  post 'crm/groups/create' => 'admin#groups_create'
  get 'crm/groups/edit/:id' => 'admin#groups_edit'
  patch 'crm/groups/edit/:id' => 'admin#groups_edit'
  get 'crm/groups/delete/:id' => 'admin#groups_delete'
  get 'crm/groups/' => 'admin#group_index'
  get 'crm/index' => 'admin#index'
  ##########################################


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
