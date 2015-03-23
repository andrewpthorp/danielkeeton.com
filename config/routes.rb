DanielkeetonCom::Application.routes.draw do

  root to: 'home#index'

  # Public: For more information on single user systems, visit the devise wiki
  # on GitHub.
  devise_for :admins, skip: :registrations

  resources :listings, only: [:show] do
    collection do
      get '/', to: 'listings#index', defaults: { status: 'for_sale' }
      get 'status/:status', to: 'listings#index', as: :status
    end
  end

  resources :posts, only: [:index, :show]
  resources :inquiries, only: [:create]
  resources :pages, only: [:show]
  resources :testimonials, only: [:index]
  resources :vendors, only: [:index]
  resources :selling, only: [:index]

  # Public: Admin routes.
  namespace :admin do

    # Public: Route /admin to /admin/listings.
    root to: 'listings#index'

    # Public: Admin routes for Listings.
    resources :listings, except: [:show]

    # Public: Admin routes for Posts.
    resources :posts, except: [:show]

    # Public: Admin routes for Pages.
    resources :pages, except: [:show]

    # Public: Admin routes for Testimonials.
    resources :testimonials, except: [:show]

    # Public: Admin routes for Vendors.
    resources :vendors, except: [:show]

    # Public: Admin routes for DynamicContents.
    resources :dynamic_contents, except: [:show]
  end

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
