require 'rails_helper'

RSpec.describe 'Mutations::Companies::UpdateCompany', type: :request do
  context 'update a company and' do
    let!(:foundator) { Foundator.create(name: 'Fabio', surname: 'Soares', age: 23) }
    let!(:company) { Company.create(name: 'Empresa', cnpj: 1234, foundator_id: foundator.id, foundation: "20/02/1997") }
    let!(:another_foundator) { Foundator.create(name: 'Naruto', surname: 'Uzumaki', age: 23) }

    it 'return successful' do
      query = "mutation {
        updateCompany(input: {
          id: #{company.id.to_i},
          name: #{'Novo Nome'.to_json},
          cnpj: 4321,
          foundation: #{'04/11/2020'.to_json},
          foundatorId: #{another_foundator.id.to_i}
        }) {
          name
          cnpj
          foundation
          foundatorId
        }
      }"

      post '/graphql', params: { query: query }
      json_response = JSON.parse(@response.body)

      expect(json_response['data']['updateCompany']).to eq(
        {
          "name"=>"Novo Nome",
          "cnpj"=>4321,
          "foundation"=>"04/11/2020",
          "foundatorId"=> another_foundator.id
        }
      )
    end

    it 'broke when params are blank' do
      query = "mutation { updateCompany(input: { params: { }) }"

      post '/graphql', params: { query: query }
      json_response = JSON.parse(@response.body)

      expect(json_response['errors'].first['message']).to match(/Parse error/)
    end

    it "return error message when company doesn't exists" do
      query = "mutation {
        updateCompany(input: {
          id: 99999,
          name: #{'Novo Nome'.to_json},
          cnpj: 4321,
          foundation: #{'04/11/2020'.to_json},
          foundatorId: #{another_foundator.id.to_i}
        }) {
          name
          cnpj
          foundation
          foundatorId
        }
      }"

      expect { post '/graphql', params: { query: query } }.to raise_error("Couldn't find Company with 'id'=99999")
    end
  end
end
