require 'rails_helper'

RSpec.describe 'Queries::FetchCompany', type: :request do
  context 'try find a company and' do
    let!(:foundator) { Foundator.create(name: 'Fabio', surname: 'Soares', age: 23) }
    let!(:company) { Company.create(name: 'Empresa1', cnpj: 1234, foundator_id: foundator.id, foundation: "20/02/1997") }

    it 'return successful' do
      query = "query {
        fetchCompany(id: #{company.id.to_i}) {
          name
          cnpj
          foundation
          foundatorId
        }
      }"

      post '/graphql', params: { query: query }
      json_response = JSON.parse(@response.body)

      expect(json_response['data']['fetchCompany']).to eq({
        'name' => 'Empresa1',
        'cnpj' => 1234,
        'foundation' => '20/02/1997',
        'foundatorId' => foundator.id
      })
    end

    it 'broke when params are blank' do
      query = "query { fetchCompanies { } }"

      post '/graphql', params: { query: query }
      json_response = JSON.parse(@response.body)

      expect(json_response['errors'].first['message']).to match(/Parse error/)
    end

    it "return error message when company doesn't exists" do
      company.destroy

      query = "query {
        fetchCompany(id: #{company.id.to_i}) {
          name
          cnpj
          foundation
          foundatorId
        }
      }"

      post '/graphql', params: { query: query }
      json_response = JSON.parse(@response.body)

      expect(json_response['errors'].first['message']).to eq('Company does not exist.')
    end
  end
end
