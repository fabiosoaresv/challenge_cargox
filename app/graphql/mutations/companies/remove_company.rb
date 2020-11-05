module Mutations
  module Companies
    class RemoveCompany < Mutations::BaseMutation
      field :company, Types::CompanyType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        company = Company.find(id)
        company.destroy!

        { company: company }
      end
    end
  end
end
