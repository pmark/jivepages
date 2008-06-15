# NOT SURE IF THIS WORKS...
resources :jivepages
resources :sites
resources :rows, :member => {:up => :put, :down => :put}
resources :columns
resources :boxes
resources :page_changes
resources :edit_sessions
resources :contributorship



# connect "/my/url", :controller => "some_controller"
# my_named_route "do_stuff", :controller => "blah", :action => "stuff"
