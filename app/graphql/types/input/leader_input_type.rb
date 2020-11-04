module Types
  module Input
    class LeaderInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :surname, String, required: true
      argument :department, String, required: true
      argument :age, Integer, required: true
      argument :foundator_id, Integer, required: true
    end
  end
end
