module Queries
  class FetchCompany < Queries::BaseQuery
    type Types::CompanyType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      Company.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new('Company does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
