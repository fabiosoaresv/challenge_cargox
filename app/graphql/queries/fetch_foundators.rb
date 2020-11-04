module Queries
  class FetchFoundators < Queries::BaseQuery

    type [Types::FoundatorType], null: false

    def resolve
      Foundator.all.order(created_at: :desc)
    end
  end
end
