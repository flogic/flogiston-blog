ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :articles
  end
  
  map.resources :articles, :only => [:index, :show]
  map.root :controller => 'dashboard', :action => 'index'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
