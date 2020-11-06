class ReportsController < ApplicationController
  before_action :initialize_variables, :report_results

  attr_reader :report_results

  def index
    @report_results
  end

  private

  def initialize_variables
    data = []
    all_companies = Company.all.map(&:name).sort
    all_companies.each do |company_name|
      company = Company.find_by(name: company_name)
      coordinators = company&.foundator&.leader&.coordinators
      foundator = company&.foundator
      leader = foundator&.leader
      juniores = coordinators&.map(&:employees)&.flatten&.select { |x| x.level == 'Junior' }
      seniores = coordinators&.map(&:employees)&.flatten&.select { |x| x.level == 'Senior' }

      data << [
        company.name,
        company.cnpj,
        foundator&.name,
        [foundator].flatten&.count.to_i + [leader].flatten&.count.to_i + coordinators&.count.to_i + juniores&.count.to_i + seniores&.count.to_i,
        [leader]&.count.to_i,
        coordinators&.count.to_i,
        seniores&.count.to_i,
        juniores&.count.to_i
      ]
    end

    @report_results = data.sort
  end
end
