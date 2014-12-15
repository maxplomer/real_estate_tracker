RealEstateTracker::Application.routes.draw do
  root :to => "properties#index"

  get 'pos_neg_leverage/show'
  
  get 'dashboard/show'
  get 'showing_or_contact/new'
  post 'showing_or_contact/create_contact'

  resources :dashboards, :only => [:show]
  resources :users, :only => [:create, :new, :edit, :update]
  resource :session, :only => [:create, :destroy, :new]
  resources :properties, :only => [:create, :new, :show, :index]


  namespace :api, :defaults => { :format => :json } do
    resources :properties, :only => [:update]
    put 'pos_neg_leverage/update'
  end
end




