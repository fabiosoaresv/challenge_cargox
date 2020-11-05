require 'rails_helper'

RSpec.describe 'Create a new Company', type: :feature do
  before do

    #visit root_path

    5.times do |i|
      Foundator.create(name: "Fabio #{i + 1}", surname: "Soares #{i + 1}", age: i + 1)
      Company.create!(name: "Company #{i + 1}", cnpj: "1234#{i + 1}", foundation: Date.today, foundator_id: Foundator.last.id)
    end
  end

  scenario 'shows all companies' do
    require 'pry'
    binding.pry
    visit companies_path
    expect(page).to have_content(account.login)
    expect(page).not_to have_content(account_disable.login)
  end

  scenario 'select an account to unblock/reset password on SAP' do
    #visit new_cliente_reset_password_sap_path
    #select account.login, from: 'reset_password[account_login]'
    #click_on 'Confirmar'
  end
end
