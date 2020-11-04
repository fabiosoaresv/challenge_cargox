module Mutations
  module Foundators
    class AddFoundator < Mutations::BaseMutation
      argument :params, Types::Input::FoundatorInputType, required: true

      field :foundator, Types::FoundatorType, null: false

      def resolve(params:)
        foundator_params = Hash params

        begin
          foundator = Foundator.create!(foundator_params)

          { foundator: foundator }
        rescue ActiveRecord::RecordInvalid => e
          GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
            " #{e.record.errors.full_messages.join(', ')}")
        end
      end
    end
  end
end
