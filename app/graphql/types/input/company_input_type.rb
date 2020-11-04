module Types
  module Input
    class CompanyInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :cnpj, String, required: true
      argument :foundation, String, required: true
      argument :foundator_id, Integer, required: true
    end
  end
end
