module Mutations
  module Companies
    class AddCompany < Mutations::BaseMutation
      argument :params, Types::Input::CompanyInputType, required: true

      field :company, Types::CompanyType, null: false

      def resolve(params:)
        company_params = Hash params

        begin
          company = Company.create!(company_params)

          { company: company }
        rescue ActiveRecord::RecordInvalid => e
          GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
            " #{e.record.errors.full_messages.join(', ')}")
        end
      end
    end
  end
end
