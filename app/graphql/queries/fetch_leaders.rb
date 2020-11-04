module Queries
  class FetchLeaders < Queries::BaseQuery

    type [Types::LeaderType], null: false

    def resolve
      Leader.all.order(created_at: :desc)
    end
  end
end
