module Types
  class FoundatorType < Types::BaseObject
    field :id, Integer, null: true
    field :name, String, null: true
    field :surname, String, null: true
    field :age, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
