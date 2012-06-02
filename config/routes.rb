DziennikOnline::Application.routes.draw do

  devise_for :users, :skip => [:registrations] do
    get "/users/edit" => "devise/registrations#edit", :as => :edit_user_registration
    put "/users" => "devise/registrations#update", :as => :user_registration
  end

  get "admin/semesters/activate/:id" => "admin/semesters#activate", :as => "set_semester_as_active"
  get "teacher/school_classes/activate/:id" => "teacher/school_classes#activate", :as => "set_school_class_as_active"
  get "teacher/semesters/activate/:id" => "teacher/semesters#activate", :as => "set_school_class_semester"

  match 'director/absences/:school_class_id' => 'director/absences#actual', :as => 'actual_director_absences'

  get "teacher/students/:id/new_password" => "teacher/students#new_password", :as => "new_password_teacher_student"
  put "teacher/students/:id/password" => "teacher/students#update_password", :as => "password_teacher_student"
  get "teacher/students/meeting_cards" => "teacher/students#meeting_cards", :as => "meeting_cards_teacher_students"

  namespace :teacher do
    resources :school_classes, :only => [:create, :destroy, :index]
    resources :semesters, :only => [:create, :destroy]
    resources :subjects
    resources :descriptions, :only => [:create, :destroy]
    resources :students
    resources :absences, :only => [:update, :index]
    resources :marks, :only => [:update]
    resources :messages, :only => [:new, :create, :edit, :update, :destroy, :index]
    resources :semestral_marks, :only => [:update]
    resources :time_tables, :only => [:new, :create, :destroy, :index]
    resources :documents, :only => [:create, :destroy, :index]
    resources :raports
  end

  namespace :director do
    get "reports/semestral" => "reports#semestral", :as => "reports_semestral"
    resources :school_classes, :only => [:index] do
      get "report" => "reports#school_class", :as => "report"
      get "semesters/:semester_id/absences" => "absences#index", :as => "semester_absences"
      resources :subjects, :only => [:show]
    end
  end


  namespace :student do
    resources :absences
    resources :marks
    resources :time_tables
    resources :messages
  end

  namespace :admin do
    resource :school, :only => [:show]
    resources :semesters
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
  root :to => 'pages#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
