class CompaniesController < ApplicationController
  def index
    query = 'query {
      fetchCompanies {
        name
        cnpj
        foundation
        foundatorId
      }
    }'

    client = ClientGraphql.new(query)
    response = client.call
    @companies = response.original_hash['data']['fetchCompanies']
  end

  def show
    #TODO
    # melhorar essa gambiarra pois deve ser no método destroy ksksks
    #ENDTODO
    company =  Company.where(cnpj: params['format']).first
    company.destroy
  end

  def create
    foundator = Foundator.where(name: company_params[:foundator_id]).first
    query = "mutation {
      addCompany(input: {
        params: {
          name: #{company_params[:name].to_json},
          cnpj: #{company_params[:cnpj].to_json},
          foundation: #{company_params[:foundation].to_json},
          foundatorId: #{foundator.id} }
        }) {
        company {
          name
          cnpj
          foundation
          foundatorId
        }
      }
    }"

    client = ClientGraphql.new(query)
    response = client.call

    if response&.original_hash
      #TODO
      # colocar mensagem de sucesso/falha
      #ENDTODO
      redirect_to '/companies'
    else
      redirect_to '/companies'
    end
  end

  def update
  end

  def edit
    @company = Company.find(params[:id])
  end

  def destroy
    require 'pry'; binding.pry
  end

  private

  def company_params
    params.require(:company).permit(:name, :cnpj, :foundation, :foundator_id)
  end
end
