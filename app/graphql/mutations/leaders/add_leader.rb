module Mutations
  module Leaders
    class AddLeader < Mutations::BaseMutation
      argument :params, Types::Input::LeaderInputType, required: true

      field :leader, Types::LeaderType, null: false

      def resolve(params:)
        leader_params = Hash params

        begin
          leader = Leader.create!(leader_params)

          { leader: leader }
        rescue ActiveRecord::RecordInvalid => e
          GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
            " #{e.record.errors.full_messages.join(', ')}")
        end
      end
    end
  end
end
