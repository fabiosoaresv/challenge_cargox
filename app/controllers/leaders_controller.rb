class LeadersController < ApplicationController
  before_action :initialize_variables

  attr_reader :foundators, :leaders, :leader

  def index
  end

  def show
    params_leader = { endpoint: 'Leader', data: 'leader { name surname age department foundatorId id }', id: params['id'] }
    client = ClientGraphql.new(params_leader)

    if client.remove
      redirect_to '/leaders', alert: 'Deletado com sucesso.'
    else
      redirect_to '/leaders', alert: 'Erro desconhecido'
    end
  end

  def create
    foundator_id = foundators.select { |x| x['name'] == leader_params[:foundator_name] }.first['id']
    params_create = {
      endpoint: 'Leader',
      data: "{
        name: #{leader_params[:name].to_json},
        surname: #{leader_params[:surname].to_json},
        age: #{leader_params[:age].to_i},
        department: #{leader_params[:department].to_json},
        foundatorId: #{foundator_id.to_i}
      }"
    }

    client = ClientGraphql.new(params_create)

    if client.add
      redirect_to '/leaders', alert: 'Criado com sucesso.'
    else
      redirect_to '/leaders', alert: 'Erro desconhecido'
    end
  end

  def update
    params_update = {
      endpoint: 'Leader',
      data: "{
        id: #{params[:id].to_i},
        name: #{params[:name].to_json},
        surname: #{params[:surname].to_json},
        age: #{params[:age].to_i},
        department: #{params[:department].to_json},
        foundatorId: #{params[:foundatorId].to_i}
      }"
    }

    client = ClientGraphql.new(params_update)

    if client.update
      redirect_to '/leaders', alert: 'Atualizado com sucesso.'
    else
      redirect_to '/leaders', alert: 'Erro desconhecido'
    end
  end

  def edit
    @leader = leaders.select { |x| x['name'] == params['id'] }.first
  end

  def destroy
  end

  private

  def leader_params
    params.require(:leader).permit(:name, :surname, :age, :department, :foundator_name)
  end

  def initialize_variables
    params_leaders = { endpoint: 'Leaders', data: 'name surname age department foundatorId id' }
    @leaders = ClientGraphql.new(params_leaders).get_entries

    params_foundators = { endpoint: 'Foundators', data: 'name id' }
    @foundators = ClientGraphql.new(params_foundators).get_entries
  end
end
