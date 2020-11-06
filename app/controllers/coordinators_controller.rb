class CoordinatorsController < ApplicationController
  before_action :initialize_variables

  attr_reader :coordinators, :leaders, :coordinator

  def index
  end

  def show
    params_coordinator = { endpoint: 'Coordinator', data: 'coordinator { name surname age hiredAt leaderId id }', id: params['id'] }
    client = ClientGraphql.new(params_coordinator)

    if client.remove
      redirect_to '/coordinators', alert: 'Deletado com sucesso.'
    else
      redirect_to '/coordinators', alert: 'Erro desconhecido'
    end
  end

  def create
    leader_id = leaders.select { |x| x['name'] == coordinator_params[:leader_name] }.first['id']
    params_create = {
      endpoint: 'Coordinator',
      data: "{
        name: #{coordinator_params[:name].to_json},
        surname: #{coordinator_params[:surname].to_json},
        age: #{coordinator_params[:age].to_i},
        hiredAt: #{coordinator_params[:hired_at].to_json},
        leaderId: #{leader_id.to_i}
      }"
    }

    client = ClientGraphql.new(params_create)

    if client.add
      redirect_to '/coordinators', alert: 'Criado com sucesso.'
    else
      redirect_to '/coordinators', alert: 'Erro desconhecido'
    end
  end

  def update
    params_update = {
      endpoint: 'Coordinator',
      data: "{
        id: #{params[:id].to_i},
        name: #{params[:name].to_json},
        surname: #{params[:surname].to_json},
        age: #{params[:age].to_i},
        hiredAt: #{params[:hiredAt].to_json},
        leaderId: #{params[:leaderId].to_i}
      }"
    }

    client = ClientGraphql.new(params_update)

    if client.update
      redirect_to '/coordinators', alert: 'Atualizado com sucesso.'
    else
      redirect_to '/coordinators', alert: 'Erro desconhecido'
    end
  end

  def edit
    @coordinator = coordinators.select { |x| x['name'] == params['id'] }.first
  end

  def destroy
  end

  private

  def coordinator_params
    params.require(:coordinator).permit(:name, :surname, :age, :hired_at, :leader_name)
  end

  def initialize_variables
    params_leaders = { endpoint: 'Leaders', data: 'name surname age department foundatorId id' }
    @leaders = ClientGraphql.new(params_leaders).get_entries

    params_coordinators = { endpoint: 'Coordinators', data: 'name id surname age hiredAt leaderId' }
    @coordinators = ClientGraphql.new(params_coordinators).get_entries
  end
end
