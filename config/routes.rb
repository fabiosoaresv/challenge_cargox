Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end

  root 'home#index'
  post "/graphql", to: "graphql#execute"
  resources :companies
  resources :foundators
  resources :leaders
  resources :coordinators
  resources :employees

  #get 'companies', to: 'companies#index'
  #get 'companies/new', to: 'companies#new'
  post 'companies/create', to: 'companies#create'
  #delete 'companies/destroy', to: 'companies#destroy'
  #post 'companies/destroy', :to => 'companies#destroy'
  #get 'companies/:id/destroy(.:format)', :to => 'companies#destroy'
  #get 'companies/:id/edit(.:format)', :to => 'companies#edit'
  #post 'companies/:id/destroy(.:format)', :to => 'companies#destroy'
  #delete 'companies/destroy', to: 'companies#destroy'
end
