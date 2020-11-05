module Mutations
  module Companies
    class UpdateCompany < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :cnpj, ID, required: true
      argument :name, String, required: false
      argument :cnpj, Integer, required: false
      argument :foundation, String, required: false
      argument :foundator_id, Integer, required: false

      type Types::CompanyType

      def resolve(params)
        company = Company.find(params[:id])
        params_update = params.except(:id)

        company.update!(params_update)

        # TODO
        # modify response to field
        # ENDTODO
        {
          id: company.id,
          name: company.name,
          cnpj: company.cnpj,
          foundation: company.foundation,
          foundator_id: company.foundator_id
        }
      end
    end
  end
end

