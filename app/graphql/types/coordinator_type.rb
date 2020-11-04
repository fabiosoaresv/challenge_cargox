module Types
  class CoordinatorType < Types::BaseObject
    field :name, String, null: true
    field :surname, String, null: true
    field :age, Integer, null: true
    field :hired_at, String, null: true
    field :leader_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
