module Queries
  class FetchCompanies < Queries::BaseQuery

    type [Types::CompanyType], null: false

    def resolve
      Company.all.order(created_at: :desc)
    end
  end
end
