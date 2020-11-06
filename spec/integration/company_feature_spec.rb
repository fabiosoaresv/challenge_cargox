require 'rails_helper'

RSpec.describe 'Company', type: :feature do
  context 'shows all companies and' do
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

    scenario 'returns with successful' do
      visit 'http://localhost:3000/companies'

      expect(page).to have_content('Empresas')
    end
  end

  context 'create a new company 'do
    let(:response) do
      instance_double(
        GraphQL::Client::Response,
          original_hash: {
            "data" => {
              "addCompany" =>
              {
                "company"=>{"name"=>"Company", "cnpj"=>001122, "foundation"=>"06/11/2020", "foundatorId"=>1 }
              }
            }
          }
       )
    end

    before do
      allow_any_instance_of(Graphlient::Client)
        .to receive(:query)
        .with("mutation {\n      addCompany(input: {\n        params: {\n        name: \"Company\",\n        cnpj: 001122,\n        foundation: \"06/11/2020\",\n        foundatorId: 1\n      }\n      }) {\n        company {\n          name\ncnpj\nfoundation\nfoundatorId\n        }\n      }\n    }")
        .and_return(response)

      Foundator.destroy_all
      Foundator.create(name: "Fabio", surname: "Soares", age: 23)

      visit 'http://localhost:3000/companies/new'

      fill_in 'company[name]', with: 'Company'
      fill_in 'company[cnpj]', with: '001122'
      fill_in 'company[foundation]', with: '06/11/2020'
      fill_in 'company[foundator_name]', with: 'Fabio'
    end

    it 'return successful' do
      click_button 'Cadastrar'

      expect(current_path).to eq('http://localhost:3000/companies')
      expect(Company.last.name).to eq('Company')
      expect(Company.last.cnpj).to eq(001122)
    end

    xit 'make specs when fails xD' do
    end
  end

  context 'edit a company 'do
   let(:response) do
      instance_double(
        GraphQL::Client::Response,
          original_hash: {
            "data" => {
              "updateCompany" =>
              {
                "company"=>{"name"=>"Company", "cnpj"=>001122, "foundation"=>"06/11/2020", "foundatorId"=>1 }
              }
            }
          }
       )
    end

    before do
      allow_any_instance_of(Graphlient::Client)
        .to receive(:query)
        .with("mutation {\n      updateCompany(input: {\n        id: 7,\n        name: \"Company Atualizada\",\n        cnpj: 1234,\n        foundation: \"06/11/2020\",\n        foundatorId: 1\n      }) {\n        id\nname\ncnpj\nfoundation\nfoundatorId\n      }\n    }")
        .and_return(response)

      Foundator.destroy_all
      Foundator.create(name: "Fabio", surname: "Soares", age: 23)
      Company.destroy_all
      Company.create(name: 'Company', cnpj: 123, foundator_id: Foundator.last.id, foundation: '01/11/2020')

      visit 'http://localhost:3000/companies/123/edit'

      fill_in 'params[name]', with: 'Company Atualizada'
      fill_in 'params[cnpj]', with: '1234'
      fill_in 'params[foundation]', with: '06/11/2020'
      fill_in 'params[foundator_name]', with: 'Fabio'
    end

    it 'return successful' do
      click_button 'Atualizar'

      expect(current_path).to eq('http://localhost:3000/companies')
      expect(Company.last.name).to eq('Company Atualizada')
      expect(Company.last.cnpj).to eq(1234)
      expect(Company.last.foundation).to eq('06/11/2020')
    end

    xit 'make specs when fails xD' do
    end
  end

  context 'delete a company 'do
    let(:response) do
      instance_double(
        GraphQL::Client::Response,
          original_hash: {
            "data" => {
              "removeCompany" =>
              {
                "company"=>{"name"=>"Company", "cnpj"=>123, "foundation"=>"01/11/2020", "foundatorId"=>1 }
              }
            }
          }
       )
    end

    before do
      allow_any_instance_of(Graphlient::Client)
        .to receive(:query)
        .with("mutation {\n      removeCompany(input: {\n        id: 1\n      }) {\n        company { name cnpj foundation foundatorId }\n      }\n    }")
        .and_return(response)

      Foundator.destroy_all
      Foundator.create(name: "Fabio", surname: "Soares", age: 23)
      Company.destroy_all
      Company.create(name: 'Company', cnpj: 123, foundator_id: Foundator.last.id, foundation: '01/11/2020')

      visit 'http://localhost:3000/companies/1'

      fill_in 'params[name]', with: 'Company Atualizada'
      fill_in 'params[cnpj]', with: '1234'
      fill_in 'params[foundation]', with: '06/11/2020'
      fill_in 'params[foundator_name]', with: 'Fabio'
    end

    it 'return successful' do
      click_button 'Deletar'

      expect(current_path).to eq('http://localhost:3000/companies')
      expect(Company.last).to be_empty
    end

    xit 'make specs when fails xD' do
    end
  end
end
