require 'rails_helper'

RSpec.describe 'Mutations::Companies::RemoveCompany', type: :request do
  context 'remove a company and' do
    let!(:foundator) { Foundator.create(name: 'Fabio', surname: 'Soares', age: 23) }
    let!(:company) { Company.create(name: 'Empresa', cnpj: 1234, foundator_id: foundator.id, foundation: "20/02/1997") }

    it 'return successful' do
      query = "mutation {
        removeCompany( input: {id: #{company.id.to_i}}) {
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

      expect(Company.last).to eq(nil)
      expect(json_response['data']['removeCompany']['company']).to eq(
        {
          "name"=>"Empresa",
          "cnpj"=>1234,
          "foundation"=>"20/02/1997",
          "foundatorId"=> foundator.id
        }
      )
    end

    it 'broke when params are blank' do
      query = "mutation { removeCompany(input: { params: { }) }"

      post '/graphql', params: { query: query }
      json_response = JSON.parse(@response.body)

      expect(json_response['errors'].first['message']).to match(/Parse error/)
    end

    it "return error message when company doesn't exists" do
      query = "mutation {
        removeCompany( input: {id: 9999) {
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

      expect(json_response['errors'].first['message']).to match(/Parse error on/)
    end
  end
end
