require 'rails_helper'

RSpec.describe 'Mutations::Companies::AddCompany', type: :request do
  context 'create a company and' do
    let!(:foundator) { Foundator.create(name: 'Fabio', surname: 'Soares', age: 23) }

    it 'return successful' do
      query = "mutation {
        addCompany(input: {
          params: {
            name: #{'Empresa'.to_json},
            cnpj: #{'1234'.to_i},
            foundation: #{'20/02/1997'.to_json},
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

      post '/graphql', params: { query: query }
      json_response = JSON.parse(@response.body)
      company = Company.last

      expect(json_response['data']['addCompany']['company']).to eq(
        {
          "name"=>"Empresa",
          "cnpj"=>1234,
          "foundation"=>"20/02/1997",
          "foundatorId"=> foundator.id
        }
      )

      expect(company.name).to eq('Empresa')
      expect(company.cnpj).to eq(1234)
      expect(company.foundation).to eq('20/02/1997')
      expect(company.foundator.id).to eq(foundator.id)
    end

    it 'broke when params are blank' do
      query = "mutation { addCompany(input: { params: { }) }"

      post '/graphql', params: { query: query }
      json_response = JSON.parse(@response.body)

      expect(json_response['errors'].first['message']).to match(/Parse error/)
    end

    it "return error message when foundator doesn't exists" do
      query = "mutation {
        addCompany(input: {
          params: {
            name: #{'Empresa'.to_json},
            cnpj: #{'1234'.to_i},
            foundation: #{'20/02/1997'.to_json},
            foundatorId: 999999 }
          }) {
          company {
            name
            cnpj
            foundation
            foundatorId
          }
        }
      }"

      post '/graphql', params: { query: query }
      json_response = JSON.parse(@response.body)

      expect(json_response['errors'].first['message']).to match(/Invalid attributes for Company: Foundator must exist/)
    end
  end
end
