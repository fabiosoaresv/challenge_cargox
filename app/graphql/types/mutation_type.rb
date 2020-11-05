module Types
  class MutationType < Types::BaseObject
    field :add_company, mutation: Mutations::Companies::AddCompany
    field :update_company, mutation: Mutations::Companies::UpdateCompany
    field :remove_company, mutation: Mutations::Companies::RemoveCompany

    field :add_foundator, mutation: Mutations::Foundators::AddFoundator
    field :add_leader, mutation: Mutations::Leaders::AddLeader
    field :add_coordinator, mutation: Mutations::Coordinators::AddCoordinator
    #field :update_coordinator, mutation: Mutations::Coordinators::UpdateCoordinator
    #field :remove_coordinator, mutation: Mutations::Coordinators::RemoveCoordinator

    field :add_employee, mutation: Mutations::Employees::AddEmployee
    field :update_employee, mutation: Mutations::Employees::UpdateEmployee
    field :remove_employee, mutation: Mutations::Employees::RemoveEmployee
  end
end
