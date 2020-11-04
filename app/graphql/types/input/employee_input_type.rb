module Types
  module Input
    class EmployeeInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :surname, String, required: true
      argument :age, Integer, required: true
      argument :salary, Integer, required: true
      argument :hired_at, String, required: true
      argument :level, String, required: true
      argument :in_experience, GraphQL::Types::Boolean, required: true
      argument :coordinator_id, Integer, required: true
    end
  end
end
