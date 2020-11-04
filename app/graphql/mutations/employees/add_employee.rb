module Mutations
  module Employees
    class AddEmployee < Mutations::BaseMutation
      argument :params, Types::Input::EmployeeInputType, required: true

      field :employee, Types::EmployeeType, null: false

      def resolve(params:)
        employee_params = Hash params

        begin
          employee = Employee.create!(employee_params)

          { employee: employee }
        rescue ActiveRecord::RecordInvalid => e
          GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
            " #{e.record.errors.full_messages.join(', ')}")
        end
      end
    end
  end
end
