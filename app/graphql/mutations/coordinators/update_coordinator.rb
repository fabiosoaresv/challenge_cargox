module Mutations
  module Coordinators
    class UpdateCoordinator < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :surname, String, required: false
      argument :age, Integer, required: false
      argument :hired_at, String, required: false
      argument :leader_id, Integer, required: false

      type Types::CoordinatorType

      def resolve(params)
        coordinator = Coordinator.find(params[:id])
        params_update = params.except(:id)

        coordinator.update!(params_update)

        {
          name: coordinator.name,
          surname: coordinator.surname,
          age: coordinator.age,
          hired_at: coordinator.hired_at
        }
      end
    end
  end
end

