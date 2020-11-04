module Queries
  class FetchFoundator < Queries::BaseQuery
    type Types::FoundatorType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      Foundator.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new('Foundator does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
