module Mutations
  module Employees
    class RemoveEmployee < Mutations::BaseMutation
      field :employee, Types::EmployeeType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        employee = Employee.find(id)
        employee.destroy!

        { employee: employee }
      end
    end
  end
end
