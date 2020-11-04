module Types
  module Input
    class FoundatorInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :surname, String, required: true
      argument :age, Integer, required: true
    end
  end
end
