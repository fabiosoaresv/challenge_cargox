module Types
  class QueryType < Types::BaseObject
    field :fetch_companies, resolver: Queries::FetchCompanies
    field :fetch_company, resolver: Queries::FetchCompany
    field :fetch_foundator, resolver: Queries::FetchFoundator
    field :fetch_foundators, resolver: Queries::FetchFoundators
    field :fetch_leader, resolver: Queries::FetchLeader
    field :fetch_leaders, resolver: Queries::FetchLeaders
    field :fetch_coordinator, resolver: Queries::FetchCoordinator
    field :fetch_coordinators, resolver: Queries::FetchCoordinators
    field :fetch_employee, resolver: Queries::FetchEmployee
    field :fetch_employees, resolver: Queries::FetchEmployees
  end
end
