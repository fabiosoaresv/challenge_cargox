require 'rails_helper'

RSpec.describe 'Queries::FetchCompanies', type: :request do
  context 'try find all companies and' do
    #TODO
    # criar factory xD
    #ENDTODO
    let!(:foundator) { Foundator.create(name: 'Fabio', surname: 'Soares', age: 23) }
    let!(:company1) { Company.create(name: 'Empresa1', cnpj: 1234, foundator_id: foundator.id, foundation: "20/02/1997") }
    let!(:company2) { Company.create(name: 'Empresa2', cnpj: 1234, foundator_id: foundator.id, foundation: "20/02/1997") }

    it 'return successful' do
      query = "query {
        fetchCompanies {
          name
          cnpj
        }
      }"

      post '/graphql', params: { query: query }
      json_response = JSON.parse(@response.body)

      expect(json_response['data']['fetchCompanies']).to match_array(
        [
          {"name"=>"Empresa2", "cnpj"=>1234},
          {"name"=>"Empresa1", "cnpj"=>1234}
        ]
      )
    end

    it 'broke when params are blank' do
      query = "query { fetchCompanies { } }"

      post '/graphql', params: { query: query }
      json_response = JSON.parse(@response.body)

      expect(json_response['errors'].first['message']).to match(/Parse error/)
    end

    it "return array empty when doesn't exists companies" do
      company1.destroy
      company2.destroy
      query = "query {
        fetchCompanies {
          name
          cnpj
        }
      }"

      post '/graphql', params: { query: query }
      json_response = JSON.parse(@response.body)

      expect(json_response['data']['fetchCompanies']).to match_array([])
    end
  end
end
