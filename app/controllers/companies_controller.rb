class CompaniesController < ApplicationController
  before_action :initialize_variables

  attr_reader :foundators, :companies, :company

  def index
  end

  def show
    params_company = { endpoint: 'Company', data: 'company { name cnpj foundation foundatorId }', id: params['id'] }
    client = ClientGraphql.new(params_company)

    if client.remove
      redirect_to '/companies', alert: 'Deletado com sucesso.'
    else
      redirect_to '/companies', alert: 'Erro desconhecido'
    end
  end

  def create
    foundator_id = @foundators.select { |x| x['name'] == company_params[:foundator_name] }.first['id']
    params_create = {
      endpoint: 'Company',
      data: "{
        name: #{company_params[:name].to_json},
        cnpj: #{company_params[:cnpj].to_i},
        foundation: #{company_params[:foundation].to_json},
        foundatorId: #{foundator_id.to_i}
      }"
    }

    client = ClientGraphql.new(params_create)

    if client.add
      redirect_to '/companies', alert: 'Deletado com sucesso.'
    else
      redirect_to '/companies', alert: 'Erro desconhecido'
    end
  end

  def update
    company_id = companies.select { |x| x['cnpj'] == params['cnpj'].to_i }.first['id']
    params_update = {
      endpoint: 'Company',
      data: "{
        id: #{company_id.to_i},
        name: #{params[:name].to_json},
        cnpj: #{params[:cnpj].to_i},
        foundation: #{params[:foundation].to_json},
        foundatorId: #{params[:foundatorId].to_i}
      }"
    }

    client = ClientGraphql.new(params_update)

    if client.update
      redirect_to '/companies'
    else
      redirect_to '/companies'
    end
  end

  def edit
    @company = @companies.select { |x| x['cnpj'] == params['id'].to_i }.first
  end

  def destroy
  end

  private

  attr_reader :companies

  def company_params
    params.require(:company).permit(:name, :cnpj, :foundation, :foundator_name)
  end

  def initialize_variables
    params_companies = { endpoint: 'Companies', data: 'name cnpj foundation foundatorId id' }
    @companies = ClientGraphql.new(params_companies).get_entries

    params_foundators = { endpoint: 'Foundators', data: 'name id' }
    @foundators = ClientGraphql.new(params_foundators).get_entries
  end
end
