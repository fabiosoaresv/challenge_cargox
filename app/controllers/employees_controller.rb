class EmployeesController < ApplicationController
  before_action :initialize_variables

  attr_reader :coordinators, :employees, :employee

  def index
  end

  def show
    params_employee = { endpoint: 'Employee', data: 'employee { name surname age salary hiredAt level inExperience coordinatorId }', id: params['id'] }
    client = ClientGraphql.new(params_employee)

    if client.remove
      redirect_to '/employees', alert: 'Deletado com sucesso.'
    else
      redirect_to '/employees', alert: 'Erro desconhecido'
    end
  end

  def create
    require 'pry'
    binding.pry
    in_expirience = employee_params[:inExperience] == "true" ? true : false
    coordinator_id = coordinators.select { |x| x['name'] == employee_params[:coordinator_name] }.first['id']
    params_create = {
      endpoint: 'Employee',
      data: "{
        name: #{employee_params[:name].to_json},
        surname: #{employee_params[:surname].to_json},
        age: #{employee_params[:age].to_i},
        salary: #{employee_params[:salary].to_i},
        hiredAt: #{employee_params[:hiredAt].to_json},
        level: #{employee_params[:level].to_json},
        inExperience: #{in_expirience},
        coordinatorId: #{coordinator_id.to_i}
      }"
    }

    client = ClientGraphql.new(params_create)

    if client.add
      redirect_to '/employees', alert: 'Criado com sucesso.'
    else
      redirect_to '/employees', alert: 'Erro desconhecido'
    end
  end

  def update
    in_expirience = params[:inExperience] == "true" ? true : false
    params_update = {
      endpoint: 'Employee',
      data: "{
        id: #{params[:id].to_i},
        name: #{params[:name].to_json},
        surname: #{params[:surname].to_json},
        age: #{params[:age].to_i},
        salary: #{params[:salary].to_i},
        hiredAt: #{params[:hiredAt].to_json},
        level: #{params[:level].to_json},
        inExperience: #{in_expirience},
        coordinatorId: #{params[:coordinatorId].to_i}
      }"
    }

    client = ClientGraphql.new(params_update)

    if client.update
      redirect_to '/employees', alert: 'Atualizado com sucesso.'
    else
      redirect_to '/employees', alert: 'Erro desconhecido'
    end
  end

  def edit
    @employee = employees.select { |x| x['name'] == params['id'] }.first
  end

  def destroy
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :surname, :age, :salary, :hiredAt, :level, :inExperience, :coordinatorId, :coordinator_name)
  end

  def initialize_variables
    params_coordinators = { endpoint: 'Coordinators', data: 'name id surname age hiredAt leaderId' }
    @coordinators = ClientGraphql.new(params_coordinators).get_entries

    params_employees = { endpoint: 'Employees', data: 'id name surname age salary hiredAt level coordinatorId inExperience' }
    @employees = ClientGraphql.new(params_employees).get_entries

    @experience = %w(true false)
    @levels = %w(Junior Senior)
  end
end
