module Queries
  class FetchLeader < Queries::BaseQuery
    type Types::LeaderType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      Leader.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new('Leader does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
