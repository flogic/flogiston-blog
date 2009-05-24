ActionController::Routing::Routes.draw do |map|
  map.resources :articles, :only => :index

  map.namespace :admin do |admin|
    admin.resources :articles
  end
end
