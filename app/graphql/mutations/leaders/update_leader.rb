module Mutations
  module Leaders
    class UpdateLeader < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :surname, String, required: false
      argument :department, String, required: false
      argument :age, Integer, required: false
      argument :foundator_id, Integer, required: false

      type Types::LeaderType

      def resolve(params)
        leader = Leader.find(params[:id])
        params_update = params.except(:id)

        leader.update!(params_update)

        {
          id: leader.id,
          name: leader.name,
          surname: leader.surname,
          department: leader.department,
          age: leader.age,
          foundator_id: leader.foundator_id
        }
      end
    end
  end
end

