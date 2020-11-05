require 'rails_helper'

RSpec.describe 'Create a new Company', type: :feature do
  let(:response) do
    instance_double(
      GraphQL::Client::Response,
        original_hash: {
          "data" => {
            "fetchCompanies" =>
            [
              {"name"=>"Company 1", "cnpj"=>12345, "foundation"=>"2020-11-05", "foundatorId"=>15},
              {"name"=>"Company 2", "cnpj"=>12344, "foundation"=>"2020-11-05", "foundatorId"=>15}
            ]
          }
        }
     )
  end

  before do
    allow_any_instance_of(Graphlient::Client)
      .to receive(:query)
      .with("query {\n      fetchCompanies {\n        name\n        cnpj\n        foundation\n        foundatorId\n      }\n    }\n")
      .and_return(response)
  end

  scenario 'shows all companies' do
    visit 'http://localhost:3000/companies'

    expect(page).to have_content('Empresas')
  end
end
