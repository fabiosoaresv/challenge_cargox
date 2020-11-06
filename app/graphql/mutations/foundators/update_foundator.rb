module Mutations
  module Foundators
    class UpdateFoundator < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :surname, String, required: false
      argument :age, Integer, required: false

      type Types::FoundatorType

      def resolve(params)
        foundator = Foundator.find(params[:id])
        params_update = params.except(:id)

        foundator.update!(params_update)

        {
          id: foundator.id,
          name: foundator.name,
          surname: foundator.surname,
          age: foundator.age
        }
      end
    end
  end
end

