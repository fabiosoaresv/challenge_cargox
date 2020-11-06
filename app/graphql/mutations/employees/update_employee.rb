module Mutations
  module Employees
    class UpdateEmployee < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :surname, String, required: false
      argument :age, Integer, required: false
      argument :hired_at, String, required: false
      argument :salary, Float, required: false
      argument :level, String, required: false
      argument :in_experience, GraphQL::Types::Boolean, required: false
      argument :coordinator_id, Integer, required: false

      type Types::EmployeeType

      def resolve(params)
        employee = Employee.find(params[:id])
        params_update = params.except(:id)

        employee.update!(params_update)

        {
          age: employee.age,
          hired_at: employee.hired_at,
          in_experience: employee.in_experience,
          level: employee.level,
          name: employee.name,
          salary: employee.salary,
          surname: employee.surname
        }
      end
    end
  end
end

