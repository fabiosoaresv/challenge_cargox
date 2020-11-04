module Queries
  class FetchCoordinators < Queries::BaseQuery

    type [Types::CoordinatorType], null: false

    def resolve
      Coordinator.all.order(created_at: :desc)
    end
  end
end
