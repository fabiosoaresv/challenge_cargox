class CompaniesController < ApplicationController
  #before_action :companies
  attr_reader :companies

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
    query = "mutation {
      removeCompany(input: {
        id: #{params['id'].to_i}
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
      redirect_to '/companies'
    else
      redirect_to '/companies'
    end
  end

  def create
    foundator = Foundator.where(name: company_params[:foundator_id]).first
    query = "mutation {
      addCompany(input: {
        params: {
          name: #{company_params[:name].to_json},
          cnpj: #{company_params[:cnpj].to_i},
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
      #<%= submit_tag "Test me!", :type => 'button', :onclick => 'alert("It works!")' %>
      redirect_to '/companies'
    else
      redirect_to '/companies'
    end
  end

  def update
    query = 'query {
      fetchCompanies {
        name
        cnpj
        foundation
        foundatorId
        id
      }
    }'

    client = ClientGraphql.new(query)
    response = client.call

    @companies = response.original_hash['data']['fetchCompanies']
    company_id = companies.select { |x| x['cnpj'] == params['cnpj'].to_i }.first['id']

    query = "mutation {
      updateCompany(input: {
        id: #{company_id.to_i},
        name: #{params[:name].to_json},
        cnpj: #{params[:cnpj].to_i},
        foundation: #{params[:foundation].to_json},
        foundatorId: #{params[:foundatorId].to_i}
      }) {
        id
        name
        cnpj
        foundation
        foundatorId
      }
    }"

    client = ClientGraphql.new(query)
    response = client.call

    if response&.original_hash
      #TODO
      # colocar mensagem de sucesso/falha
      #ENDTODO
      #<%= submit_tag "Test me!", :type => 'button', :onclick => 'alert("It works!")' %>
      redirect_to '/companies'
    else
      redirect_to '/companies'
    end
  end

  def edit
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

    #TODO
    # melhorar essa query
    #ENDTODO
    companies = response.original_hash['data']['fetchCompanies']
    @company = companies.select { |x| x['cnpj'] == params['id'].to_i }.first
  end

  def destroy
  end

  private

  attr_reader :companies

  def company_params
    params.require(:company).permit(:name, :cnpj, :foundation, :foundator_id)
  end

  def initialize_companies(companies)
    @companies ||= companies
  end
end
