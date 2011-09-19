GtdNew::Application.routes.draw do

  get "about/department", :as => :department_about
  resources :posts, :only => [:index, :show]
  resources :softwares, :only => [:index, :show] do
    resources :attachments, :only => [] do
      member do
        put :download
      end
    end
  end
  resources :services, :only => [:index, :show]
  resources :businesses, :only => [:index, :new, :create, :show, :update] do
    member do
      get :add_feedback
      put :add_feedback
    end
  end

  devise_for :users, :controllers => { :registrations => "users", :passwords => "passwords",:sessions => "sessions" }

  root :to => "home#index"
  get "home/index"


  namespace :admin do
    match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

    root :to => "main#index"

    resources :departments
    resources :services
    resources :users, :except => [:destroy] do
      member do
        get :show_colorbox
      end
    end
    resources :posts, :controller => 'items', :default => { :resource_class => 'Post' }
    resources :softwares, :controller => 'items', :default => { :resource_class => 'Software' }
    resources :businesses do
      member do
        get :show_colorbox
        get :assign
        put :assign
        get :accept
        put :accept
        get :finish
        put :finish
        get :process_feedback
        put :process_feedback
      end
    end
    resources :tasks do
      member do
        get :show_colorbox
        get :accept
        put :accept
        get :finish
        put :finish
      end
    end
  end
end

#== Route Map
# Generated on 18 Sep 2011 04:51
#
#                           posts GET    /posts(.:format)                                       {:action=>"index", :controller=>"posts"}
#                            post GET    /posts/:id(.:format)                                   {:action=>"show", :controller=>"posts"}
#        sent_software_attachment GET    /softwares/:software_id/attachments/:id/sent(.:format) {:action=>"sent", :controller=>"attachments"}
#                       softwares GET    /softwares(.:format)                                   {:action=>"index", :controller=>"softwares"}
#                        software GET    /softwares/:id(.:format)                               {:action=>"show", :controller=>"softwares"}
#                        services GET    /services(.:format)                                    {:action=>"index", :controller=>"services"}
#                         service GET    /services/:id(.:format)                                {:action=>"show", :controller=>"services"}
#                      businesses GET    /businesses(.:format)                                  {:action=>"index", :controller=>"businesses"}
#                                 POST   /businesses(.:format)                                  {:action=>"create", :controller=>"businesses"}
#                    new_business GET    /businesses/new(.:format)                              {:action=>"new", :controller=>"businesses"}
#                        business GET    /businesses/:id(.:format)                              {:action=>"show", :controller=>"businesses"}
#                new_user_session GET    /users/sign_in(.:format)                               {:action=>"new", :controller=>"sessions"}
#                    user_session POST   /users/sign_in(.:format)                               {:action=>"create", :controller=>"sessions"}
#            destroy_user_session DELETE /users/sign_out(.:format)                              {:action=>"destroy", :controller=>"sessions"}
#                   user_password POST   /users/password(.:format)                              {:action=>"create", :controller=>"passwords"}
#               new_user_password GET    /users/password/new(.:format)                          {:action=>"new", :controller=>"passwords"}
#              edit_user_password GET    /users/password/edit(.:format)                         {:action=>"edit", :controller=>"passwords"}
#                                 PUT    /users/password(.:format)                              {:action=>"update", :controller=>"passwords"}
#        cancel_user_registration GET    /users/cancel(.:format)                                {:action=>"cancel", :controller=>"users"}
#               user_registration POST   /users(.:format)                                       {:action=>"create", :controller=>"users"}
#           new_user_registration GET    /users/sign_up(.:format)                               {:action=>"new", :controller=>"users"}
#          edit_user_registration GET    /users/edit(.:format)                                  {:action=>"edit", :controller=>"users"}
#                                 PUT    /users(.:format)                                       {:action=>"update", :controller=>"users"}
#                                 DELETE /users(.:format)                                       {:action=>"destroy", :controller=>"users"}
#                            root        /(.:format)                                            {:controller=>"home", :action=>"index"}
#                      home_index GET    /home/index(.:format)                                  {:controller=>"home", :action=>"index"}
#                  admin_calendar        /admin/calendar(/:year(/:month))(.:format)             {:year=>/\d{4}/, :month=>/\d{1,2}/, :controller=>"admin/calendar", :action=>"index"}
#                      admin_root        /admin(.:format)                                       {:controller=>"admin/main", :action=>"index"}
#               admin_departments GET    /admin/departments(.:format)                           {:action=>"index", :controller=>"admin/departments"}
#                                 POST   /admin/departments(.:format)                           {:action=>"create", :controller=>"admin/departments"}
#            new_admin_department GET    /admin/departments/new(.:format)                       {:action=>"new", :controller=>"admin/departments"}
#           edit_admin_department GET    /admin/departments/:id/edit(.:format)                  {:action=>"edit", :controller=>"admin/departments"}
#                admin_department GET    /admin/departments/:id(.:format)                       {:action=>"show", :controller=>"admin/departments"}
#                                 PUT    /admin/departments/:id(.:format)                       {:action=>"update", :controller=>"admin/departments"}
#                                 DELETE /admin/departments/:id(.:format)                       {:action=>"destroy", :controller=>"admin/departments"}
#                  admin_services GET    /admin/services(.:format)                              {:action=>"index", :controller=>"admin/services"}
#                                 POST   /admin/services(.:format)                              {:action=>"create", :controller=>"admin/services"}
#               new_admin_service GET    /admin/services/new(.:format)                          {:action=>"new", :controller=>"admin/services"}
#              edit_admin_service GET    /admin/services/:id/edit(.:format)                     {:action=>"edit", :controller=>"admin/services"}
#                   admin_service GET    /admin/services/:id(.:format)                          {:action=>"show", :controller=>"admin/services"}
#                                 PUT    /admin/services/:id(.:format)                          {:action=>"update", :controller=>"admin/services"}
#                                 DELETE /admin/services/:id(.:format)                          {:action=>"destroy", :controller=>"admin/services"}
#        show_colorbox_admin_user GET    /admin/users/:id/show_colorbox(.:format)               {:action=>"show_colorbox", :controller=>"admin/users"}
#                     admin_users GET    /admin/users(.:format)                                 {:action=>"index", :controller=>"admin/users"}
#                                 POST   /admin/users(.:format)                                 {:action=>"create", :controller=>"admin/users"}
#                  new_admin_user GET    /admin/users/new(.:format)                             {:action=>"new", :controller=>"admin/users"}
#                 edit_admin_user GET    /admin/users/:id/edit(.:format)                        {:action=>"edit", :controller=>"admin/users"}
#                      admin_user GET    /admin/users/:id(.:format)                             {:action=>"show", :controller=>"admin/users"}
#                                 PUT    /admin/users/:id(.:format)                             {:action=>"update", :controller=>"admin/users"}
#                     admin_posts GET    /admin/posts(.:format)                                 {:action=>"index", :controller=>"admin/items"}
#                                 POST   /admin/posts(.:format)                                 {:action=>"create", :controller=>"admin/items"}
#                  new_admin_post GET    /admin/posts/new(.:format)                             {:action=>"new", :controller=>"admin/items"}
#                 edit_admin_post GET    /admin/posts/:id/edit(.:format)                        {:action=>"edit", :controller=>"admin/items"}
#                      admin_post GET    /admin/posts/:id(.:format)                             {:action=>"show", :controller=>"admin/items"}
#                                 PUT    /admin/posts/:id(.:format)                             {:action=>"update", :controller=>"admin/items"}
#                                 DELETE /admin/posts/:id(.:format)                             {:action=>"destroy", :controller=>"admin/items"}
#                 admin_softwares GET    /admin/softwares(.:format)                             {:action=>"index", :controller=>"admin/items"}
#                                 POST   /admin/softwares(.:format)                             {:action=>"create", :controller=>"admin/items"}
#              new_admin_software GET    /admin/softwares/new(.:format)                         {:action=>"new", :controller=>"admin/items"}
#             edit_admin_software GET    /admin/softwares/:id/edit(.:format)                    {:action=>"edit", :controller=>"admin/items"}
#                  admin_software GET    /admin/softwares/:id(.:format)                         {:action=>"show", :controller=>"admin/items"}
#                                 PUT    /admin/softwares/:id(.:format)                         {:action=>"update", :controller=>"admin/items"}
#                                 DELETE /admin/softwares/:id(.:format)                         {:action=>"destroy", :controller=>"admin/items"}
#    show_colorbox_admin_business GET    /admin/businesses/:id/show_colorbox(.:format)          {:action=>"show_colorbox", :controller=>"admin/businesses"}
#           assign_admin_business GET    /admin/businesses/:id/assign(.:format)                 {:action=>"assign", :controller=>"admin/businesses"}
#                                 PUT    /admin/businesses/:id/assign(.:format)                 {:action=>"assign", :controller=>"admin/businesses"}
# process_feedback_admin_business GET    /admin/businesses/:id/process_feedback(.:format)       {:action=>"process_feedback", :controller=>"admin/businesses"}
#                                 PUT    /admin/businesses/:id/process_feedback(.:format)       {:action=>"process_feedback", :controller=>"admin/businesses"}
#                admin_businesses GET    /admin/businesses(.:format)                            {:action=>"index", :controller=>"admin/businesses"}
#                                 POST   /admin/businesses(.:format)                            {:action=>"create", :controller=>"admin/businesses"}
#              new_admin_business GET    /admin/businesses/new(.:format)                        {:action=>"new", :controller=>"admin/businesses"}
#             edit_admin_business GET    /admin/businesses/:id/edit(.:format)                   {:action=>"edit", :controller=>"admin/businesses"}
#                  admin_business GET    /admin/businesses/:id(.:format)                        {:action=>"show", :controller=>"admin/businesses"}
#                                 PUT    /admin/businesses/:id(.:format)                        {:action=>"update", :controller=>"admin/businesses"}
#                                 DELETE /admin/businesses/:id(.:format)                        {:action=>"destroy", :controller=>"admin/businesses"}
#        show_colorbox_admin_task GET    /admin/tasks/:id/show_colorbox(.:format)               {:action=>"show_colorbox", :controller=>"admin/tasks"}
#               assign_admin_task GET    /admin/tasks/:id/assign(.:format)                      {:action=>"assign", :controller=>"admin/tasks"}
#                                 PUT    /admin/tasks/:id/assign(.:format)                      {:action=>"assign", :controller=>"admin/tasks"}
#     process_feedback_admin_task GET    /admin/tasks/:id/process_feedback(.:format)            {:action=>"process_feedback", :controller=>"admin/tasks"}
#                                 PUT    /admin/tasks/:id/process_feedback(.:format)            {:action=>"process_feedback", :controller=>"admin/tasks"}
#                     admin_tasks GET    /admin/tasks(.:format)                                 {:action=>"index", :controller=>"admin/tasks"}
#                                 POST   /admin/tasks(.:format)                                 {:action=>"create", :controller=>"admin/tasks"}
#                  new_admin_task GET    /admin/tasks/new(.:format)                             {:action=>"new", :controller=>"admin/tasks"}
#                 edit_admin_task GET    /admin/tasks/:id/edit(.:format)                        {:action=>"edit", :controller=>"admin/tasks"}
#                      admin_task GET    /admin/tasks/:id(.:format)                             {:action=>"show", :controller=>"admin/tasks"}
#                                 PUT    /admin/tasks/:id(.:format)                             {:action=>"update", :controller=>"admin/tasks"}
#                                 DELETE /admin/tasks/:id(.:format)                             {:action=>"destroy", :controller=>"admin/tasks"}
#                   routing_error        /routing_error(.:format)                               {:action=>"rescue", :controller=>"routing_error"}
#               kindeditor_upload POST   /kindeditor/upload(.:format)                           {:controller=>"kindeditor/assets", :action=>"create"}
#          kindeditor_filemanager GET    /kindeditor/filemanager(.:format)                      {:controller=>"kindeditor/assets", :action=>"list"}

