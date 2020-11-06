Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end

  resources :companies
  resources :foundators
  resources :leaders
  resources :coordinators
  resources :employees
  resources :reports

  root 'home#index'
  post "/graphql", to: "graphql#execute"
  post 'companies/create', to: 'companies#create'
  post 'companies/update', to: 'companies#update'
  post 'foundators/create', to: 'foundators#create'
  post 'foundators/update', to: 'foundators#update'
  post 'leaders/create', to: 'leaders#create'
  post 'leaders/update', to: 'leaders#update'
  post 'coordinators/create', to: 'coordinators#create'
  post 'coordinators/update', to: 'coordinators#update'
  post 'employees/create', to: 'employees#create'
  post 'employees/update', to: 'employees#update'
end
