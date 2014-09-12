Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
  get '/crm' => 'admin#index'
  get 'crm/groups/' => 'admin#groups_index'
  get 'crm/groups/create' => 'admin#groups_create', :as => 'create_group'
  post 'crm/groups/create' => 'admin#groups_create'
  get 'crm/groups/edit/:id' => 'admin#groups_edit'
  patch 'crm/groups/edit/:id' => 'admin#groups_edit'
  get 'crm/groups/delete/:id' => 'admin#groups_delete'
  get 'crm/groups/' => 'admin#groups_index'
  get 'crm/index' => 'admin#index'

  get 'crm/users' => 'admin#users_index'
  get 'crm/users/edit/:id' => 'admin#users_edit'
  patch 'crm/users/edit/:id' => 'admin#users_edit'

  get 'crm/categories' => 'admin#categories_index', :as => 'index_categories'
  get 'crm/categories/create' => 'admin#categories_create'
  post 'crm/categories/create' => 'admin#categories_create'
  get 'crm/categories/edit/:id' => 'admin#categories_edit', :as => 'edit_category'
  get 'crm/categories/delete/:id' => 'admin#categories_delete', as: 'delete_category'
  patch 'crm/categories/edit/:id' => 'admin#categories_edit'
  get 'crm/categories/edit/:id/add' => 'admin#categories_create_question', :as => 'add_question'
  post 'crm/categories/edit/:id/add' => 'admin#categories_create_question'
  get 'crm/categories/question/delete/:id' => 'admin#categories_delete_question', :as => 'delete_question'
  
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
