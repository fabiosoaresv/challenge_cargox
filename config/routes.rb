Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end

  resources :companies
  resources :foundators
  resources :leaders
  resources :coordinators
  resources :employees

  root 'home#index'
  post "/graphql", to: "graphql#execute"
  post 'companies/create', to: 'companies#create'
  post 'companies/update', to: 'companies#update'
  post 'foundators/create', to: 'foundators#create'
  post 'foundators/update', to: 'foundators#update'

end
