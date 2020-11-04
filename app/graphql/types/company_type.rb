module Types
  class CompanyType < Types::BaseObject
    field :name, String, null: true
    field :cnpj, Integer, null: true
    field :foundation, String, null: true
    field :foundator_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
