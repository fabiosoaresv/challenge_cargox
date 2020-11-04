module Types
  module Input
    class CoordinatorInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :surname, String, required: true
      argument :age, Integer, required: true
      argument :hired_at, String, required: true
      argument :leader_id, Integer, required: true
    end
  end
end
