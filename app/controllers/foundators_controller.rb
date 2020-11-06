class FoundatorsController < ApplicationController
  before_action :initialize_variables

  attr_reader :foundators

  def index
  end

  def show
    params_foundator = { endpoint: 'Foundator', data: 'foundator { name surname age }', id: params['id'] }
    client = ClientGraphql.new(params_foundator)

    if client.remove
      redirect_to '/foundators', alert: 'Deletado com sucesso.'
    else
      redirect_to '/foundators', alert: 'Erro desconhecido'
    end
  end

  def create
    params_create = {
      endpoint: 'Foundator',
      data: "{
        name: #{foundator_params[:name].to_json},
        surname: #{foundator_params[:surname].to_json},
        age: #{foundator_params[:age].to_i}
      }"
    }

    client = ClientGraphql.new(params_create)

    if client.add
      redirect_to '/foundators', alert: 'Criado com sucesso.'
    else
      redirect_to '/foundators', alert: 'Erro desconhecido'
    end
  end

  def update
    params_update = {
      endpoint: 'Foundator',
      data: "{
        id: #{params[:id].to_i},
        name: #{params[:name].to_json},
        surname: #{params[:surname].to_json},
        age: #{params[:age].to_i}
      }"
    }

    client = ClientGraphql.new(params_update)

    if client.update
      redirect_to '/foundators', alert: 'Atualizado com sucesso.'
    else
      redirect_to '/foundators', alert: 'Erro desconhecido'
    end
  end

  def edit
    @foundator = foundators.select { |x| x['name'] == params['id'] }.first
  end

  def destroy
  end

  private

  attr_reader :foundators

  def foundator_params
    params.require(:foundator).permit(:name, :surname, :age)
  end

  def initialize_variables
    params_foundators = { endpoint: 'Foundators', data: 'name surname age id' }
    @foundators = ClientGraphql.new(params_foundators).get_entries
  end
end
