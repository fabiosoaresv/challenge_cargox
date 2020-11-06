module Mutations
  module Foundators
    class RemoveFoundator < Mutations::BaseMutation
      field :foundator, Types::FoundatorType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        foundator = Foundator.find(id)
        foundator.destroy!

        { foundator: foundator }
      end
    end
  end
end
