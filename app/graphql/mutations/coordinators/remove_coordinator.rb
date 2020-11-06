module Mutations
  module Coordinators
    class RemoveCoordinator < Mutations::BaseMutation
      field :coordinator, Types::CoordinatorType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        coordinator = Coordinator.find(id)
        coordinator.destroy!

        { coordinator: coordinator }
      end
    end
  end
end
