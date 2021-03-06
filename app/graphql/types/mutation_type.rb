module Types
  class MutationType < Types::BaseObject
    field :add_company, mutation: Mutations::Companies::AddCompany
    field :update_company, mutation: Mutations::Companies::UpdateCompany
    field :remove_company, mutation: Mutations::Companies::RemoveCompany
    field :add_foundator, mutation: Mutations::Foundators::AddFoundator
    field :update_foundator, mutation: Mutations::Foundators::UpdateFoundator
    field :remove_foundator, mutation: Mutations::Foundators::RemoveFoundator
    field :add_leader, mutation: Mutations::Leaders::AddLeader
    field :update_leader, mutation: Mutations::Leaders::UpdateLeader
    field :remove_leader, mutation: Mutations::Leaders::RemoveLeader
    field :add_coordinator, mutation: Mutations::Coordinators::AddCoordinator
    field :update_coordinator, mutation: Mutations::Coordinators::UpdateCoordinator
    field :remove_coordinator, mutation: Mutations::Coordinators::RemoveCoordinator
    field :add_employee, mutation: Mutations::Employees::AddEmployee
    field :update_employee, mutation: Mutations::Employees::UpdateEmployee
    field :remove_employee, mutation: Mutations::Employees::RemoveEmployee
  end
end
