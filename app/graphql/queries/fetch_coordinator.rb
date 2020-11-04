module Queries
  class FetchCoordinator < Queries::BaseQuery
    type Types::CoordinatorType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      Coordinator.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new('Coordinator does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
