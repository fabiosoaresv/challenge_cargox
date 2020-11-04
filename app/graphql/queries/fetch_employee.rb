module Queries
  class FetchEmployee < Queries::BaseQuery
    type Types::EmployeeType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      Employee.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new('Employee does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
