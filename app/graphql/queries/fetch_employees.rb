module Queries
  class FetchEmployees < Queries::BaseQuery

    type [Types::EmployeeType], null: false

    def resolve
      Employee.all.order(created_at: :desc)
    end
  end
end
