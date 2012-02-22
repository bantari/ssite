Ssite::Application.routes.draw do

  devise_for :users

  resources :users do
    member do 
      get :activate
      get :edit_roles
      put :update_roles
    end
  end

  resources :brands
  resources :event_logs
  resources :categories
  
  resources :document_types

  resources :skus do
    member do 
      get :publish
      get :activate
    end
  end
  
  resources :documents do
    member do 
      get :publish
      get :activate
    end
  end
  resources :publications do
    member do 
      get :publish
      get :activate
    end
  end

  resources :courses do
    member do 
      get :publish
      get :activate
      get :show_with_actions
      get :edit_search
      put :update_search
      get :edit_overview
      put :update_overview
      get :edit_specifications
      put :update_specifications
      get :edit_css_styles
      put :update_css_styles
      get :edit_documents
      put :update_documents
      get :edit_products
      put :update_products
      get :edit_media
      put :update_media
    end
  end

  resources :products do
    member do 
      get :publish
      get :activate
      get :show_with_actions
      get :edit_search
      put :update_search
      get :edit_overview
      put :update_overview
      get :edit_specifications
      put :update_specifications
      get :edit_css_styles
      put :update_css_styles
      get :edit_documents
      put :update_documents
      get :edit_products
      put :update_products
      get :edit_media
      put :update_media
    end
  end

  resources :course_documents
  resources :course_publications
  resources :course_references
  resources :course_components
  resources :course_suggestions
  resources :course_relations
  resources :course_images
  resources :course_vdeos
  resources :course_promos
  resources :course_menus
  resources :course_banners
  resources :course_styles
  resources :product_documents
  resources :product_publications
  resources :product_references
  resources :product_components
  resources :product_suggestions
  resources :product_relations
  resources :product_images
  resources :product_vdeos
  resources :product_promos
  resources :product_menus
  resources :product_banners
  resources :product_styles
  resources :brand_suggestions
  resources :brand_promos
  resources :brand_menus
  resources :brand_banners
  resources :brand_styles
  resources :category_suggestions
  resources :category_promos
  resources :category_menus
  resources :category_banners
  resources :category_styles
  resources :page_documents
  resources :page_publications
  resources :page_images
  resources :page_vdeos
  resources :page_promos
  resources :page_menus
  resources :page_banners
  resources :page_styles
  resources :survey_documents
  resources :survey_publications
  resources :survey_images
  resources :survey_vdeos
  resources :survey_promos
  resources :survey_menus
  resources :survey_banners
  resources :survey_styles

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

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
  root :to => "products#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
