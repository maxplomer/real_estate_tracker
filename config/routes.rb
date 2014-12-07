RealEstateTracker::Application.routes.draw do
  root :to => "properties#index"

  get 'dashboard/show'
  get 'showing_or_contact/add'
  resources :users, :only => [:create, :new, :edit, :update]
  resource :session, :only => [:create, :destroy, :new]
  resources :properties, :only => [:create, :new, :show, :index]
end




