module Mutations
  module Coordinators
    class AddCoordinator < Mutations::BaseMutation
      argument :params, Types::Input::CoordinatorInputType, required: true

      field :coordinator, Types::CoordinatorType, null: false

      def resolve(params:)
        coordinator_params = Hash params

        begin
          coordinator = Coordinator.create!(coordinator_params)

          { coordinator: coordinator }
        rescue ActiveRecord::RecordInvalid => e
          GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
            " #{e.record.errors.full_messages.join(', ')}")
        end
      end
    end
  end
end
