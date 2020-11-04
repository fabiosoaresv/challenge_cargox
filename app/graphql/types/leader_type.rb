module Types
  class LeaderType < Types::BaseObject
    field :name, String, null: true
    field :surname, String, null: true
    field :age, Integer, null: true
    field :department, String, null: true
    field :foundator_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
