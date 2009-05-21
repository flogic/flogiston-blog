ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :articles
  end

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
