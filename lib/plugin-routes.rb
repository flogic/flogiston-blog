ActionController::Routing::Routes.draw do |map|
  map.resources :articles, :only => [:index, :show]

  map.namespace :admin do |admin|
    admin.resources :articles
  end
end
