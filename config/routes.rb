Rails.application.routes.draw do
  resources :folders
  resources :assets
  get 'home/index'

  devise_for :users 

  #this route is for file downloads 
  match "assets/get/:id" => "assets#get", :via => [:get], :as => "download"

  match "browse/:folder_id" => "home#browse", :via => [:get], :as => "browse"

  match "browse/:folder_id/new_folder" => "folders#new", :via => [:get], :as => "new_sub_folder"

  match "browse/:folder_id/new_file" => "assets#new", :via => [:get], :as => "new_sub_file"


  #match 'gallery_:id' => 'gallery#show', :via => [:get], :as => 'gallery_show'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
